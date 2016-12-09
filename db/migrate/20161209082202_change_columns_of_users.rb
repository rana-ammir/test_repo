class ChangeColumnsOfUsers < ActiveRecord::Migration
  def change
    add_column :users, :organization_id, :string
  	remove_column :users, :organization_name, :string
  	remove_column :users, :address, :text
  end
end
