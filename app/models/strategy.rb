class Strategy < ActiveRecord::Base
	belongs_to :objective
	
	has_many :tactics,  dependent: :destroy
	has_many :team_strategies
	has_many :teams, -> { uniq }, through: :team_strategies
	has_many :user_strategies
	has_many :users, -> { uniq }, through: :user_strategies
	has_many :assets, as: :assetable, dependent: :destroy
  
  after_update :update_objective
  after_create :update_objective
  after_destroy :update_objective
  
  accepts_nested_attributes_for :assets, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :description, :number, :end_on
  validates_numericality_of :totalhours, greater_than_or_equal_to: 0,  allow_nil: true
  validates_numericality_of :percent_complete, greater_than_or_equal_to: 0, less_than_or_equal_to: 100, allow_nil: true

  private

  def update_objective
  	objective = self.objective
    objective_strategies = objective.strategies
    totalhours = objective_strategies.pluck(:totalhours).sum
    actual_hours = objective_strategies.pluck(:actual_hours).sum
    end_on_date = objective_strategies.pluck(:end_on).max
    strategies_count = objective_strategies.count
    strategies_percent_sum =  objective_strategies.pluck(:percent_complete).sum
    final_stratgies_percent = strategies_percent_sum/strategies_count
    objective.update_attributes(totalhours: totalhours, actual_hours: actual_hours, end_on: end_on_date,
      percent_complete: final_stratgies_percent )
  end
end
