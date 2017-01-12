class PlanObjective < ActiveRecord::Base
	belongs_to :plan
	belongs_to :objective
end
