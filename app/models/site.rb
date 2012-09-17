class Site < ActiveRecord::Base
  attr_accessible :name, :user_id
  has_many :visits
  belongs_to :user
end
