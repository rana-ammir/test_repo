class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
    	t.string   :name
	    t.integer  :fiscal_year
	    t.date     :begin_on
	    t.date     :end_on
	    t.string   :status
	    t.integer  :department_id
	    t.integer  :organization_id
	    t.timestamps null: false
    end
  end
end
