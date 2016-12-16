ActiveAdmin.register Organization do
	permit_params :name, :address
	controller do
    skip_before_filter :authenticate_user!
	end
	
	index do
	  selectable_column
	  id_column
	  column :name
	  column :address
	  column :created_at
	  actions
	end

	filter :name
  filter :created_at

  form do |f|
    f.inputs "Organization Details" do
      f.input :name
      f.input :address
    end
    f.actions
  end
end