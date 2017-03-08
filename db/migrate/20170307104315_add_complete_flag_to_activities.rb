class AddCompleteFlagToActivities < ActiveRecord::Migration
  def change
  	add_column :activities, :completion_flag, :boolean, default: false
  end
end
