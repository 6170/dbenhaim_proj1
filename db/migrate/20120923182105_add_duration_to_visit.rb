class AddDurationToVisit < ActiveRecord::Migration
  def change
    add_column :visits, :duration, :integer
  end
end
