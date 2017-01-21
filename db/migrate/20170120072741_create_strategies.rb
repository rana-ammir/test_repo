class CreateStrategies < ActiveRecord::Migration
  def change
    create_table :strategies do |t|
    	t.text     :description
	    t.integer  :fiscal_year
	    t.integer  :budget_dollars,       limit: 2
	    t.integer  :budget_fte,           limit: 8
	    t.date     :begin_on
	    t.date     :end_on
	    t.decimal  :percent_complete,                  precision: 5,  scale: 2, default: 0.0
	    t.decimal  :percent_of_objective,              precision: 10, scale: 2
	    t.date     :completed_on
	    t.integer  :objective_id
	    t.integer  :number
	    t.decimal  :totalhours,                        precision: 5,  scale: 2, default: 0.0
	    t.integer  :tactics_count,                     default: 0
	    t.decimal  :actual_hours,                      precision: 5,  scale: 2, default: 0.0
      t.timestamps null: false
    end
  end
end
