class CreateSites < ActiveRecord::Migration
  def change
  	drop_table :sites
    create_table :sites do |t|
      t.string :name
      t.integer :visits
      t.integer :user_id
      
      
      t.timestamps
    end
  end
end
