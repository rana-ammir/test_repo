class CreateUserStrategies < ActiveRecord::Migration
  def change
    create_table :user_strategies do |t|
    	t.integer :strategy_id
    	t.integer :user_id
      t.timestamps null: false
    end
  end
end
