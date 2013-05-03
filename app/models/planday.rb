class Planday < ActiveRecord::Base
  attr_accessible :planday_spots_attributes

  belongs_to :plan
  has_many :planday_spots
  has_many :spots, through: :planday_spots
  accepts_nested_attributes_for :planday_spots

  validates :day, presence: true
end
