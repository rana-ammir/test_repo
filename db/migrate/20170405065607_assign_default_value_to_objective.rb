class AssignDefaultValueToObjective < ActiveRecord::Migration
  def change
  	change_column :objectives, :budgeted_dollars, :decimal, precision: 15, scale: 2, :default => 0.0
  end
end
