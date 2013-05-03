class Planday < ActiveRecord::Base
  belongs_to :plan
  attr_accessible :day
end
