class AddOwnerInUserObjectives < ActiveRecord::Migration
  def change
  	add_column :user_objectives, :owner, :boolean, default: false
  end
end
