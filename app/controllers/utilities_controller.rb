class UtilitiesController < ApplicationController
	include UtilityReport
	
	def report_hours
		@member_filter = User::FILTER_MEMBERS.values.map{ |filter| [ filter[:name], filter[:id] ] }
		@plans = current_user.organization_plans.active_plans
	end

	def get_filtered_members
		@member_filter_id = params[:member_filter_id].to_i
		@options = get_options_for_hours_report(@member_filter_id)
		respond_to do |format|
		  format.js
		end
	end

	def generate_report_hours
		@plan = Plan.find(params[:plan_id])
		@class = params[:class_name].constantize
		@resource = @class.find(params[:id])
		@users = get_users_for_hours_report(@plan, @resource)
		respond_to do |format|
			format.pdf do
	    	pdf = ReportHoursPdf.new(@users)
	     	send_data pdf.render, filename: "strategic_plan_members_report", type: "application/pdf", disposition: "inline"
	   end
		end
	end

end
