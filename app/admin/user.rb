ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :role_id, :username, :first_name, :last_name,
    :organization_id, :division_id, :department_id, :job_title
  
  controller do
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
      f.input :role_id , as: :select, collection: User::Role::DISPLAY_NAMES.values, prompt: "Select role type"
      f.input :division_id, as: :select, collection: Division.all, prompt: "Select division"
      f.input :department_id, as: :select, collection: Department.where(division_id: user.division_id)
    end
    f.actions
  end

end
