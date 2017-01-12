class UserObjective < ActiveRecord::Base
	belongs_to :user
	belongs_to :objective
end
