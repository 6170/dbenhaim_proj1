class Visit < ActiveRecord::Base
  attr_accessible :browser, :data, :event, :referer, :url, :site_id, :ip_address, :location, :location_full
  belongs_to :site
end
