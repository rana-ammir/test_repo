class Plan < ActiveRecord::Base
	belongs_to :department
  belongs_to :organization
  
  has_many :plan_objectives
	has_many :objectives, through: :plan_objectives

  validates_presence_of :name, :fiscal_year, :begin_on, :end_on, :status
  
  scope :active_plans, -> { where(status: "active") }
  scope :sort_asc_plans, -> { order(fiscal_year: :asc) }
	
  def self.organization_plans_list(organization_id)
  	where(organization_id: organization_id)        
  end
end
