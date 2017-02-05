class AddOwnerInUserTactics < ActiveRecord::Migration
  def change
  	add_column :user_tactics, :owner, :boolean, default: false
  end
end
