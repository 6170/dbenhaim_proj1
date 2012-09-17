class UpdateSite < ActiveRecord::Migration
  def up
  	create_table :sites do |t|
      t.string :name
      t.integer :visits
      t.integer :user_id
      
      
      t.timestamps
  end

  def down
  	drop_table :sites
  end
end