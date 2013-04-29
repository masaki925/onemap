class Authentication < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :user_id, :provider, :uid
  belongs_to :user
end
