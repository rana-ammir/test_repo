class Plan < ActiveRecord::Base
	belongs_to :department
  belongs_to :organization

  validates_presence_of :name, :fiscal_year, :begin_on, :end_on, :status

  def self.organization_plans_list(organization_id)
  	where(organization_id: organization_id)        
  end
end
