class ChangeUserboardsStatusToBoolean < ActiveRecord::Migration
  def change
  	change_column :userboards, :status, :boolean, default: true
  end
end
