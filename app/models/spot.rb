class Spot < ActiveRecord::Base
  attr_accessible :name, :address, :tel, :station, :take_time, :cost
  has_many :plandays, through: :planday_spot
end
