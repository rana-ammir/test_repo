class ChangeUserboardsStatusToBoolean < ActiveRecord::Migration
  def change
  	remove_column :userboards, :status
  	add_column :userboards, :status, :boolean, default: true
  end
end
