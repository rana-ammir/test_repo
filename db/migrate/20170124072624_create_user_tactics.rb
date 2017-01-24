class CreateUserTactics < ActiveRecord::Migration
  def change
    create_table :user_tactics do |t|
    	t.integer :user_id
    	t.integer :tactic_id
      t.timestamps null: false
    end
  end
end
