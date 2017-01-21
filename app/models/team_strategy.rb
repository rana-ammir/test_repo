class TeamStrategy < ActiveRecord::Base
	belongs_to :team
	belongs_to :strategy
end
