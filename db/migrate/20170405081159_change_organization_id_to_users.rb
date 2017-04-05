class ChangeOrganizationIdToUsers < ActiveRecord::Migration
  def change
  	change_column :users, :organization_id, 'integer USING CAST(organization_id AS integer)'
  end
end
