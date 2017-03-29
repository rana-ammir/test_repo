class ReportHoursPdf < Prawn::Document
	
	def initialize(users, plan)
		super(top_margin: 70)	
		@plan = plan	
		@users = users
		text "Date: #{Date.today.strftime("%m/%d/%Y")}"
		@users.each do |user|
			if user.objectives.present? && plan.objectives.present?
				move_down 20
				table [["Member Name", user.fullname ]], width: bounds.width, column_widths: {0 => 95}
				move_down 20
				table [["Strategic Plan", plan.name ]], width: bounds.width, column_widths: {0 => 95}
				move_down 20
				user_objs = user.objectives
				plan_objs = plan.objectives
				final_objs = plan_objs & user_objs
				table [["Total Hours Assigned", final_objs.map(&:actual_hours).sum]], width: bounds.width, column_widths: {0 => 130}	
				move_down 20
				text "Total Hours by Objective:"			
				dynamic_data = []
				arr_head = []
				arr_head << "Hours"
				arr_head << "Objective"
				dynamic_data << arr_head
				final_objs.each do |obj|
					arr = []
					arr << obj.actual_hours.to_s
					arr << obj.description 
					dynamic_data << arr
				end
				move_down 10
				table dynamic_data, width: bounds.width, column_widths: {0 => 50}
				if user != @users.last
					start_new_page
				end
			end
		end
	end

end