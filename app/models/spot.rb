class Spot < ActiveRecord::Base
  attr_accessible :name, :address, :tel, :station, :take_time, :cost
end
