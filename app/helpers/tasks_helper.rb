module TasksHelper

	def tactic_task(tactic_id)
		@tactic_task = Task.where(tactic_id: tactic_id).first
	end
end