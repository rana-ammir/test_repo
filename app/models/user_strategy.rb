class UserStrategy < ActiveRecord::Base
	belongs_to :user
	belongs_to :strategy
end
