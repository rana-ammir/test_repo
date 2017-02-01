class Objective < ActiveRecord::Base
	belongs_to :goal

	has_many :team_objectives
	has_many :teams, -> { uniq }, through: :team_objectives
	has_many :plan_objectives
	has_many :plans, through: :plan_objectives
	has_many :user_objectives
	has_many :users, -> { uniq }, through: :user_objectives
	has_many :strategies,  dependent: :destroy
	has_many :tactics, through: :strategies
	has_many :assets, as: :assetable, dependent: :destroy
  
  accepts_nested_attributes_for :assets, reject_if: :all_blank, allow_destroy: true
  
  validates_presence_of :description, :number, :requested_by_date
	
	OBJECTIVE_STATUS = {
		single_year: {id: 0, name: 'Single Year'},
    on_going: {id: 1, name: 'On Going'},
    carry_forward: {id: 2, name: 'Carry Forward'}
  }
end
