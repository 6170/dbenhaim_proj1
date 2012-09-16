class CreateVisits < ActiveRecord::Migration
  def change
    # drop_table :visits
    create_table :visits do |t|
      t.string :browser
      t.string :url
      t.string :referer
      t.string :event
      t.string :data

      t.integer :site_id

      t.timestamps
    end
  end
end
