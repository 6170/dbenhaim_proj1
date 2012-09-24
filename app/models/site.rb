class Site < ActiveRecord::Base
  attr_accessible :name, :user_id
  has_many :visitors
  belongs_to :user
end
