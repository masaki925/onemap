class Planday < ActiveRecord::Base
  attr_accessible :planday_spots_attributes

  belongs_to :plan
  has_many :planday_spots
  has_many :spots, through: :planday_spots
  accepts_nested_attributes_for :planday_spots

  validates :day, presence: true

  def clear_spot_positions
    self.planday_spots.map do |ps|
      # TODO: avoiding treat about complex add, sort, remove spot list for now.
      ps.position = -1 if ps.position != -1
    end
  end
end
