class CreatePlanObjectives < ActiveRecord::Migration
  def change
    create_table :plan_objectives do |t|
    	t.integer :plan_id
    	t.integer :objective_id
      t.timestamps null: false
    end
  end
end
