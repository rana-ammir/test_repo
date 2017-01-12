class CreateUserObjectives < ActiveRecord::Migration
  def change
    create_table :user_objectives do |t|
    	t.integer :user_id
    	t.integer :objective_id
      t.timestamps null: false
    end
  end
end
