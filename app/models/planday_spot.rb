class PlandaySpot < ActiveRecord::Base
  attr_accessible :spot_attributes, :position

  belongs_to :planday
  belongs_to :spot
  accepts_nested_attributes_for :spot
end
