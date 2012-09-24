class AddVisitorIdToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :visitor_id, :integer
  end
end
