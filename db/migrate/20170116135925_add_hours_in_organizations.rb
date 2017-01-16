class AddHoursInOrganizations < ActiveRecord::Migration
  def change
  	add_column :organizations, :hours_in_day, :decimal, precision: 10, scale: 2
  end
end
