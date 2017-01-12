class Team < ActiveRecord::Base
	has_many :team_users
	has_many :users, -> { uniq }, through: :team_users
	has_many :team_objectives
	has_many :objectives, through: :team_objectives
	
	belongs_to :organization

	validates :name, presence: true
end
