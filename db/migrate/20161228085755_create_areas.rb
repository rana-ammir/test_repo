class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
    	t.string :description
    	t.integer :number
    	t.integer :division_id
      t.timestamps null: false
    end
  end
end
