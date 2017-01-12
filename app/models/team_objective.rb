class TeamObjective < ActiveRecord::Base
	belongs_to :team
	belongs_to :objective
end
