class RemoveTaskIdFromUserboardsAndAddUserboardIdToTasks < ActiveRecord::Migration
  def change
  	remove_column :userboards, :task_id
  	add_column :tasks, :task_id, :integer
  end
end
