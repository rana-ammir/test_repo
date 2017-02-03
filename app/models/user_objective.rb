class UserObjective < ActiveRecord::Base
	belongs_to :user
	belongs_to :objective

	scope :existing_user_objective, -> (user_id,obj_id) { where(user_id: user_id, objective_id: obj_id) }
end
