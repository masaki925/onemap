class Spot < ActiveRecord::Base
  attr_accessible :name, :google_reference, :address, :tel, :station, :take_time, :cost, :lat, :lng
  has_many :plandays, through: :planday_spot
end
