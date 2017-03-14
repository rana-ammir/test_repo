class Userboard < ActiveRecord::Base
	belongs_to :user
	belongs_to :task

	validates :name, :userboard_type, :color, :user_id, presence: true
	
	scope :current_organization_user_userboards, -> (user_ids) { where(user_id: user_ids) }
end
