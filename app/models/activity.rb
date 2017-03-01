class Activity < ActiveRecord::Base
	belongs_to :task
	validates :activity_date, :start_time, :end_time, :hours, :created_by_user_id,
	 :updated_by_user_id, :updated_at, :task_id, presence: true, on: :create
	
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
end
