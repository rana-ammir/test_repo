class Area < ActiveRecord::Base
	belongs_to :division
	
	validates :description, presence: true
	validates :number, presence: true
end
