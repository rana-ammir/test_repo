class Area < ActiveRecord::Base
	belongs_to :division
	has_many :goals, dependent: :destroy
		
	validates :description, presence: true
	validates :number, presence: true
end
