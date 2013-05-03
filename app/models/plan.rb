class Plan < ActiveRecord::Base
  attr_accessible :end_datetime, :start_datetime, :title, :valid_f

  belongs_to :user
end
