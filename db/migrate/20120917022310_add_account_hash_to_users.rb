class AddAccountHashToUsers < ActiveRecord::Migration
  def change
    add_column :users, :account_hash, :string
  end
end
