class CreateTactics < ActiveRecord::Migration
  def change
    create_table :tactics do |t|
	    t.text     :description
	    t.date     :begin_on
	    t.date     :end_on
	    t.date     :completed_on
	    t.decimal  :percent_complete,    precision: 5,  scale: 2
	    t.decimal  :percent_of_strategy, precision: 5,  scale: 2
	    t.integer  :assignee_id
	    t.string   :status
	    t.integer  :strategy_id
	    t.integer  :number
	    t.decimal  :days,                precision: 10, scale: 2, default: 0.0
	    t.decimal  :hours,               precision: 10, scale: 2, default: 0.0
	    t.decimal  :totalhours,          precision: 5,  scale: 2, default: 0.0
	    t.decimal  :actual_days,         precision: 5,  scale: 2, default: 0.0
	    t.decimal  :actual_hours,        precision: 5,  scale: 2, default: 0.0
	    t.decimal  :total_actual_hours,  precision: 5,  scale: 2, default: 0.0
      t.timestamps null: false
    end
  end
end
