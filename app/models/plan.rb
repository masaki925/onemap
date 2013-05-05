class Plan < ActiveRecord::Base
  attr_accessible :end_date, :start_date, :title, :valid_f

  belongs_to :user
  has_many :plandays

  validates :title, presence: true
end
