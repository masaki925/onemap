class PlandaySpot < ActiveRecord::Base
  attr_accessible :spot_attributes, :position

  belongs_to :planday
  belongs_to :spot
  accepts_nested_attributes_for :spot

  def autosave_associated_records_for_spot
    if new_spot = Spot.where(name: spot.name).first
      self.spot = new_spot
    else
      self.spot = spot if self.spot.save!
    end
  end
end
