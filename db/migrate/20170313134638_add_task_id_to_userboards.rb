class AddTaskIdToUserboards < ActiveRecord::Migration
  def change
  	add_column :userboards, :task_id, :integer
  end
end
