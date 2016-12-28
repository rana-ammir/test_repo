class Team < ActiveRecord::Base
	has_many :team_users
	has_many :users, -> { uniq }, through: :team_users
	belongs_to :organization

	validates :name, presence: true
end
