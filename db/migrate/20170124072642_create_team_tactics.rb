class CreateTeamTactics < ActiveRecord::Migration
  def change
    create_table :team_tactics do |t|
    	t.integer :team_id
    	t.integer :tactic_id
      t.timestamps null: false
    end
  end
end
