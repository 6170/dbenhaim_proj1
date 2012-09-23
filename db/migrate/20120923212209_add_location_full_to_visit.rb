class AddLocationFullToVisit < ActiveRecord::Migration
  def change
    add_column :visits, :location_full, :string
  end
end
