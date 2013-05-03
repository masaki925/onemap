class PlandaySpot < ActiveRecord::Base
  belongs_to :planday
  belongs_to :spot
end
