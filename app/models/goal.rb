class Goal < ActiveRecord::Base
	belongs_to :area
  belongs_to :department
  has_many :objectives, dependent: :destroy
  has_many :assets, as: :assetable, dependent: :destroy
  
  accepts_nested_attributes_for :assets, reject_if: :all_blank, allow_destroy: true
  
  validates :number, presence: true
	validates :description, presence: true

	scope :sort_asc_goals, -> { order(number: :asc) }
end
