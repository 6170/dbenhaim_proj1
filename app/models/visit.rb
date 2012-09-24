class Visit < ActiveRecord::Base
  attr_accessible :browser, :data, :event, :referer, :url, :site_id, :ip_address, :location, :location_full, :visitor_id
  belongs_to :visitor
end
