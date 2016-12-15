class AddUserIdToTables < ActiveRecord::Migration
  def change
  	add_column :users, :division_id, :integer
  	add_column :users, :department_id, :integer
  	add_column :users, :job_title, :string
  end
end
