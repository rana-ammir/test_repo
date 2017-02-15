class UserTactic < ActiveRecord::Base
	belongs_to :user
	belongs_to :tactic
	
	scope :existing_user_tactic, -> (user_id,tactic_id) { where(user_id: user_id, tactic_id: tactic_id) }
	scope :active_owner, -> { where(owner: true).first }
end
