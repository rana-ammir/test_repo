module ObjectivesHelper
	def objective_owner_name objective
		if objective.user_objectives.present?
			user = objective.user_objectives.where(owner: true).first.user
			user.present? ? user.fullname : "N/A"
		else
			"N/A"
		end
	end
end
