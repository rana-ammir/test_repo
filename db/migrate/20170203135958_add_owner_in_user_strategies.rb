class AddOwnerInUserStrategies < ActiveRecord::Migration
  def change
  	add_column :user_strategies, :owner, :boolean, default: false
  end
end
