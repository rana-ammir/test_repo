ActiveAdmin.register Team do
	permit_params :name, :active, :organization_id
	
	controller do
		autocomplete :team, :organization
    skip_before_filter :authenticate_user!
	end
	
	collection_action :autocomplete_organization_name, method: :get do
    @organizations = Organization.where("name LIKE ?", "%#{params[:term]}%")
    render json: @organizations.map{|f| {"value" => f.name , "key" => f.id} }.to_json
  end
  
	index do
	  selectable_column
	  id_column
	  column :name
	  column :active
	  column :created_at
	  actions
	end

	filter :name
	filter :active
  filter :created_at

  form do |f|
    f.inputs "Team Details" do
      f.input :name
      f.fields_for :organization, f.object.organization do |ii|
        ii.input :name, label: 'Organization', as: :autocomplete, url: autocomplete_organization_name_admin_teams_path
      end
      f.hidden_field :organization_id, id: "team_organization_id" 
      f.input :active
    end
    f.actions
  end
end