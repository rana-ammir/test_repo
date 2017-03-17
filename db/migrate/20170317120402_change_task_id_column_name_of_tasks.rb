class ChangeTaskIdColumnNameOfTasks < ActiveRecord::Migration
  def change
  	rename_column :tasks, :task_id, :userboard_id
  end
end
