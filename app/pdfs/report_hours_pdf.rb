class ReportHoursPdf < Prawn::Document
	
	def initialize(users)
		super(top_margin: 70)		
		@users = users
		text "Date: #{Date.today.strftime("%m/%d/%Y")}"
		@users.each do |user|
			move_down 20
			table [["Member Name", user.fullname ]], width: bounds.width, column_widths: {0 => 95}
			move_down 20
			table [["Strategic Plan", user.objectives.first.plans.first.name ]], width: bounds.width, column_widths: {0 => 95}
			move_down 20
			table [["Total Hours Assigned", user.objectives.pluck(:actual_hours).sum]], width: bounds.width, column_widths: {0 => 130}	
			move_down 20
			text "Total Hours by Objective:"			
			dynamic_data = []
			arr_head = []
			arr_head << "Hours"
			arr_head << "Objective"
			dynamic_data << arr_head
			user.objectives.each do |obj|
				arr = []
				arr << obj.actual_hours.to_s
				arr << obj.description 
				dynamic_data << arr
			end
			move_down 10
			table dynamic_data, width: bounds.width, column_widths: {0 => 50}
		end
	end

end