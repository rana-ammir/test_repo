class Strategy < ActiveRecord::Base
	belongs_to :objective

	has_many :team_strategies
	has_many :teams, -> { uniq }, through: :team_strategies
	has_many :user_strategies
	has_many :users, -> { uniq }, through: :user_strategies
	has_many :assets, as: :assetable, dependent: :destroy
  
  accepts_nested_attributes_for :assets, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :description, :number, :end_on
  validates_numericality_of :totalhours, greater_than_or_equal_to: 0,  allow_nil: true
  validates_numericality_of :percent_complete, greater_than_or_equal_to: 0, less_than_or_equal_to: 100, allow_nil: true
end
