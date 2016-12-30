class Plan < ActiveRecord::Base
	belongs_to :department
  belongs_to :organization

  validates_presence_of :name, :fiscal_year, :begin_on, :end_on, :status
end
