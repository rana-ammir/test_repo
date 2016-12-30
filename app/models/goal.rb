class Goal < ActiveRecord::Base
	belongs_to :area
  belongs_to :department

  validates :number, presence: true
	validates :description, presence: true
	validates :description, presence: true
  
end
