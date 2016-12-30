class Department < ActiveRecord::Base
	belongs_to :division
	has_many :users
	has_many :goals
	has_many :plans, dependent: :destroy

	validates_presence_of :name
end
