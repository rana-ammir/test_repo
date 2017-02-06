class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
    	t.integer :tactic_id
    	t.string :task_type
    	t.string :description
    	t.string :status
    	t.date :due_date
    	t.integer :requestor_id
    	t.integer :assigned_to_id
    	t.decimal :actual_hours ,        precision: 5,  scale: 2, default: 0.0
    	t.date :completion_date
    	t.decimal :progress,        precision: 5,  scale: 2, default: 0.0 
    	t.timestamps null: false
    end
  end
end
