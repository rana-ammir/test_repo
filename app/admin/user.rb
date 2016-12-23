ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :role_id, :username, :first_name, :last_name,
    :organization_id, :division_id, :department_id, :job_title
  
  collection_action :autocomplete_organization_name, method: :get do
    @organizations = Organization.where("name LIKE ?", "%#{params[:term]}%")
    render json: @organizations.map{|f| {"value" => f.name , "key" => f.id} }.to_json
  end
  
  controller do
    autocomplete :user, :organization
    skip_before_filter :authenticate_user!
  end
  
  index do
    selectable_column
    id_column
    column :email
    column :username
    column :first_name
    column :last_name
    column :organization_id
    column :division_id
    column :department_id
    column :job_title
    column :role_id do |user|
      User::Role::DISPLAY_NAMES.values_at(user.role_id).to_s.gsub(/[^0-9 a-z]/i, '')
    end
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end
  
  show do
    attributes_table do
      row :email
      row :username
      row :first_name
      row :last_name
      row :organization_id
      row :division_id
      row :department_id
      row :job_title
      row :role_id do |user|
        User::Role::DISPLAY_NAMES.values_at(user.role_id).to_s.gsub(/[^0-9 a-z]/i, '')
      end
      row :current_sign_in_at
      row :sign_in_count
      row :created_at
    end
  end

  filter :email
  filter :username
  filter :first_name
  filter :last_name
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :username
      f.input :first_name
      f.input :last_name
      f.input :job_title
      f.input :role_id , as: :select, collection: User::Role::DISPLAY_NAMES.to_a.map{ |u| [u.second, u.first] }, prompt: "Select role type"
      f.fields_for :organization, f.object.organization do |ii|
        ii.input :name, label: 'Organization', as: :autocomplete, url: autocomplete_organization_name_admin_users_path
      end
      f.hidden_field :organization_id, id: "organization_id" 
      f.input :division_id, as: :select, collection: Division.all, prompt: "Select division", :input_html => { :class => "division-select" }
      f.input :department_id, as: :select, collection: Department.all, prompt: "Select department"
    end
    f.actions
  end

end
