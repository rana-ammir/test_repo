class ChangeOrganizationIdToUsers < ActiveRecord::Migration
  def change
  	change_column :users, :organization_id, :integer
  end
end
