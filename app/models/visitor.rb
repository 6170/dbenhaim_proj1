class Visitor < ActiveRecord::Base
  attr_accessible :name, :site_id
  belongs_to :site
  has_many :visits
end
