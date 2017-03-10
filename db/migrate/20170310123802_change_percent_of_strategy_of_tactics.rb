class ChangePercentOfStrategyOfTactics < ActiveRecord::Migration
  def change
  	change_column :tactics, :percent_of_strategy, :decimal, precision: 5,  scale: 2, default: 0.0
  end
end
