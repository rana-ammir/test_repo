class UserStrategy < ActiveRecord::Base
	belongs_to :user
	belongs_to :strategy
	
	scope :existing_user_strategy, -> (user_id,strategy_id) { where(user_id: user_id, strategy_id: strategy_id) }	
end
