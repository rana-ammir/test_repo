class Organization < ActiveRecord::Base
  has_many :users, dependent: :destroy
  has_many :divisions, dependent: :destroy
  has_many :teams

  validates_presence_of :name
end
