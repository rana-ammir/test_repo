class Division < ActiveRecord::Base
	belongs_to :organization
	has_many :departments, dependent: :destroy
	has_many :users
end
