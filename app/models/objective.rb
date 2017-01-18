class Objective < ActiveRecord::Base
	belongs_to :goal

	has_many :team_objectives
	has_many :teams, -> { uniq }, through: :team_objectives
	has_many :plan_objectives
	has_many :plans, through: :plan_objectives
	has_many :user_objectives
	has_many :users, -> { uniq }, through: :user_objectives
	has_many :assets, as: :assetable, dependent: :destroy
  
  accepts_nested_attributes_for :assets, reject_if: :all_blank, allow_destroy: true
  
  validates_presence_of :description, :number, :requested_by_date, :budgeted_dollars
  
end
