class UtilitiesController < ApplicationController

	def report_hours
		@member_filter = User::FILTER_MEMBERS.values.map{ |filter| [ filter[:name], filter[:id] ] }
		@plans = current_user.organization_plans
	end

	def get_filtered_members
		@member_filter_id = params[:member_filter_id].to_i
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
		respond_to do |format|
		  format.js
		end
	end

	def generate_report_hours
		@plan = Plan.find(params[:plan_id])
		@class = params[:class_name].constantize
		@resource = @class.find(params[:id])
	end

end
