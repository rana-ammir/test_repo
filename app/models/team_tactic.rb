class TeamTactic < ActiveRecord::Base
	belongs_to :team
	belongs_to :tactic
end
