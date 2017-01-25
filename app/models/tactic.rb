class Tactic < ActiveRecord::Base
	belongs_to :strategy
	before_save :convert_days_to_hours_and_sum
	has_many :team_tactics
	has_many :teams, -> { uniq }, through: :team_tactics
	has_many :user_tactics
	has_many :users, -> { uniq }, through: :user_tactics
	has_many :assets, as: :assetable, dependent: :destroy
  
  accepts_nested_attributes_for :assets, reject_if: :all_blank, allow_destroy: true
  
  validates_presence_of :description, :number, :end_on, :actual_days, :actual_hours, :days, :hours, :percent_of_strategy
  validates_numericality_of :percent_of_strategy, greater_than_or_equal_to: 0, less_than_or_equal_to: 100, allow_nil: true
  validates_numericality_of :percent_complete, greater_than_or_equal_to: 0, less_than_or_equal_to: 100, allow_nil: true
  
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
end
