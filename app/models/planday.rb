class Planday < ActiveRecord::Base
  belongs_to :plan
  has_many :spots, through: :planday_spot

  validates :day, presence: true
end
