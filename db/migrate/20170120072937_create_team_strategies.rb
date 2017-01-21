class CreateTeamStrategies < ActiveRecord::Migration
  def change
    create_table :team_strategies do |t|
    	t.integer :strategy_id
    	t.integer :team_id
      t.timestamps null: false
    end
  end
end
