class Activity < ActiveRecord::Base
	belongs_to :task
	
	validates :activity_date, :start_time, :end_time, :hours, :created_by_user_id,
	 :updated_by_user_id, :updated_at, :task_id, presence: true, on: :create
	
	after_update :update_task_progress
	after_create :update_task_status
	after_create :add_actual_hours_in_tactic, if: :strategic_plan_type?
	after_update :update_actual_hours_in_tactic, if: :strategic_plan_type?	
	after_destroy :remove_actual_hours_in_tactic, if: :strategic_plan_type?
	
	def start_time= time
		if time.is_a?(String)
			utc_time = time.to_time.utc
			self[:start_time] = utc_time
		end
	end

	def end_time= time
		if time.is_a?(String)
			utc_time = time.to_time.utc
			self[:end_time] = utc_time
		end
	end

	def hours= data
		if data.is_a?(String)
			time_in_secs = self[:end_time] - self[:start_time]
			self[:hours] = time_in_secs/1.hour
		end
	end

	def updated_at= datetime
		if datetime.is_a?(String)
			utc_datetime = datetime.to_datetime.utc
			self[:updated_at] = utc_datetime
		end
	end

	def calendar_json
		{
			title: self.description,
			start: "#{self.activity_date.strftime '%Y-%m-%d'}#{self.start_time.strftime 'T%H:%M:%S'}",
			end: "#{self.activity_date.strftime '%Y-%m-%d'}#{self.end_time.strftime 'T%H:%M:%S'}",
			task_id: self.task_id,
			activity_id: self.id
		}
	end

	def strategic_plan_type?
		self.task.task_type == "SP"
	end

	private

	def update_task_progress
		activity = self
		task = activity.task
		if activity.completion_flag_changed?
			if activity.completion_flag == true
				task.update_attributes(progress: 100, status: "Completed", completion_date: Date.today)
			elsif activity.completion_flag == false
				task.update_attributes(progress: 99.99, status: "In-Progress", completion_date: nil)
			end
		end	
	end

	def update_task_status
		task = self.task
		task.update_attributes(task_type: "In-Progress") if task.new_task?
	end

	def add_actual_hours_in_tactic
		activity_hours = self.hours
		tactic = self.task.tactic
		tactic_total_actual_hours = tactic.total_actual_hours
		total_hours = tactic_total_actual_hours + activity_hours
		tactic.update_attributes(total_actual_hours: total_hours)	
	end

	def update_actual_hours_in_tactic
		activity = self
		if activity.hours_changed?
			tactic = self.task.tactic
			tactic_total_actual_hours = tactic.total_actual_hours
			if activity.hours_was < activity.hours
				result_current_was = activity.hours - activity.hours_was
				total_hours = tactic_total_actual_hours + result_current_was	
			elsif activity.hours_was > activity.hours
				result_was_current = activity.hours_was - activity.hours 
				total_hours = tactic_total_actual_hours - result_was_current
			end	
			tactic.update_attributes(total_actual_hours: total_hours)	
		end
	end

	def remove_actual_hours_in_tactic
		activity_hours = self.hours
		tactic = self.task.tactic
		tactic_total_actual_hours = tactic.total_actual_hours
		total_hours = tactic_total_actual_hours - activity_hours
		tactic.update_attributes(total_actual_hours: total_hours)
	end
end
