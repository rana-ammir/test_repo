module TasksHelper

	def tactic_task(tactic_id)
		@tactic_task = Task.where(tactic_id: tactic_id).first
	end

	def task_user(user_id)
		@user = User.find(user_id)
	end
end