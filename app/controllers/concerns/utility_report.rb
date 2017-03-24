module UtilityReport
  extend ActiveSupport::Concern

  def get_options_for_hours_report(member_filter_id)
  	@organization = current_user.organization
  	case @member_filter_id
		when 1
			#member
			@options = @organization.users.not_organization_administrator
		when 2
			#team
		  @options = @organization.teams
		when 3
			#department
		  @options = @organization.departments
		when 4
			#division
		  @options = @organization.divisions
		when 5
			#organization
		  @options = Organization.all
		end
  end

  def get_users_for_hours_report(plan, resource)
  	@plan = plan
  	@resource = resource
  	if @resource.class.name == "User"
			@users = [@resource] 
		elsif @resource.class.name == "Organization" || @resource.class.name == "Team" || @resource.class.name == "Division" || @resource.class.name == "Department"
			@users = @resource.users.not_organization_administrator				 
  	end
  end

end