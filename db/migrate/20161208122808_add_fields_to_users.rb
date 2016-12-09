class AddFieldsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :organization_name, :string
  	add_column :users, :address, :text
  	add_column :users, :username, :string
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  end
end
