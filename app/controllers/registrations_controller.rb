class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
    @organization= Organization.create(name: params[:user][:organization][:name], address: params[:user][:organization][:address], hours_in_day: params[:user][:organization][:hours_in_day])
  	resource.update_attributes(organization_id: @organization.id)	
  end

  def update
    super
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end 
