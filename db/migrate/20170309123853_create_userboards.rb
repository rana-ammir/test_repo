class CreateUserboards < ActiveRecord::Migration
  def change
    create_table :userboards do |t|
    	t.string :name
    	t.string :userboard_type
    	t.string :color
    	t.string :status 
    	t.integer :user_id
    	t.timestamps null: false
    end
  end
end
