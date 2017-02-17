class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
    	t.date :activity_date
    	t.time :start_time
    	t.time :end_time
    	t.decimal :hours,        precision: 5,  scale: 2, default: 0.0
    	t.integer :created_by_user_id
    	t.integer :updated_by_user_id
    	t.timestamps null: false
    end
  end
end
