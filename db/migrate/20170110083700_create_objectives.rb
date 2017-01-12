class CreateObjectives < ActiveRecord::Migration
  def change
    create_table :objectives do |t|
    	t.text     :description
	    t.string   :status
	    t.date     :begin_on
	    t.date     :end_on
	    t.integer  :goal_id
	    t.integer  :number
	    t.decimal  :totalhours,                           precision: 5,  scale: 2, default: 0.0
	    t.decimal  :percent_complete,                     precision: 10, scale: 2, default: 0.0
	    t.integer  :strategies_count,                     default: 0
	    t.date     :requested_by_date
	    t.integer  :on_going_carry_forward, 							limit: 2, default: 0
	    t.decimal  :budgeted_dollars,                     precision: 15, scale: 2
	    t.decimal  :actual_hours,                         precision: 5,  scale: 2, default: 0.0
      t.timestamps null: false
    end
  end
end
