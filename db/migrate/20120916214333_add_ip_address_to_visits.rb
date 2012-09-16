class AddIpAddressToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :ip_address, :string
  end
end
