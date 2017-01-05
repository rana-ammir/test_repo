class Goal < ActiveRecord::Base
	belongs_to :area
  belongs_to :department
  has_many :assets, as: :assetable, dependent: :destroy
  
  accepts_nested_attributes_for :assets, reject_if: :all_blank, allow_destroy: true
  
  validates :number, presence: true
	validates :description, presence: true  
end
