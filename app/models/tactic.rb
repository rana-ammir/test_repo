class Tactic < ActiveRecord::Base
	belongs_to :strategy
  
  has_one :task
  
  has_many :team_tactics
	has_many :teams, -> { uniq }, through: :team_tactics
	has_many :user_tactics
	has_many :users, -> { uniq }, through: :user_tactics
  has_many :assets, as: :assetable, dependent: :destroy
  
  before_create :convert_days_to_hours_and_sum
  after_update :update_strategy
  after_create :update_strategy
  after_destroy :update_strategy

  accepts_nested_attributes_for :assets, reject_if: :all_blank, allow_destroy: true
  
  validates_presence_of :description, :number, :end_on, :actual_days, :actual_hours, :days, :hours, :percent_of_strategy
  validates_numericality_of :percent_of_strategy, greater_than_or_equal_to: 0, less_than_or_equal_to: 100, allow_nil: true
  validates_numericality_of :percent_complete, greater_than_or_equal_to: 0, less_than_or_equal_to: 100, allow_nil: true
  
  def tactic_user_obj_owner
    user_obj = self.strategy.objective.user_objectives
    if user_obj.present?
      user_obj.active_owner ? user_obj.active_owner.user_id : nil
    end
  end

  def tactic_user_owner
    user_tactics = self.user_tactics
    if user_tactics.present?
      user_tactics.active_owner ? user_tactics.active_owner.user_id : nil
    end
  end

  private
  
  def convert_days_to_hours_and_sum
    organization_hours =  User.current_user.organization.hours_in_day
  	days = self.days
  	days_hours = days * organization_hours
  	hours = self.hours
  	self.totalhours = days_hours + hours
  	actual_days = self.actual_days
  	actual_days_hours = actual_days * organization_hours
  	actual_hours = self.actual_hours
  	self.total_actual_hours = actual_days_hours + actual_hours 
  end

  def update_strategy
    strategy = self.strategy
    strategy_tactics = strategy.tactics
    totalhours = strategy_tactics.pluck(:totalhours).sum  
    total_actual_hours = strategy_tactics.pluck(:total_actual_hours).sum
    end_on_date = strategy_tactics.pluck(:end_on).max
    tactics_count = strategy_tactics.count
    tactics_percent_sum = strategy_tactics.pluck(:percent_of_strategy).sum
    final_tactics_percent = tactics_percent_sum / (tactics_count == 0 ? 1 : tactics_count) 
    strategy.update_attributes(totalhours: totalhours, actual_hours: total_actual_hours, end_on: end_on_date,
     percent_complete: final_tactics_percent )
  end
end
