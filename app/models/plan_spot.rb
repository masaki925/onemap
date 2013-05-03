class PlanSpot < ActiveRecord::Base
  belongs_to :spot
  # attr_accessible :title, :body
end
