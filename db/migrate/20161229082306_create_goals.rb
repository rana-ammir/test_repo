class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
    	t.text :description
    	t.integer  :area_id
    	t.integer  :department_id
    	t.integer :number
      t.timestamps null: false
    end
  end
end
