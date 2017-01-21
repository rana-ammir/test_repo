class Team < ActiveRecord::Base
	has_many :team_users
	has_many :users, -> { uniq }, through: :team_users
	has_many :team_objectives
	has_many :objectives, through: :team_objectives
	has_many :team_strategies
	has_many :strategies, through: :team_strategies

	belongs_to :organization

	validates :name, presence: true
end
