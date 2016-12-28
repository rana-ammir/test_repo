class Division < ActiveRecord::Base
	belongs_to :organization
	has_many :departments, dependent: :destroy
	has_many :users
	has_many :areas, dependent: :destroy
end
