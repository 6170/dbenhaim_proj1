class AddLocationToVisit < ActiveRecord::Migration
  def change
    add_column :visits, :location, :string
  end
end
