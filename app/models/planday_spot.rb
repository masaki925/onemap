class PlandaySpot < ActiveRecord::Base
  belongs_to :planday
  belongs_to :spot
  # attr_accessible :title, :body
end
