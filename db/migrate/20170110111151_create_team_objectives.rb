class CreateTeamObjectives < ActiveRecord::Migration
  def change
    create_table :team_objectives do |t|
    	t.integer :team_id
    	t.integer :objective_id
      t.timestamps null: false
    end
  end
end
