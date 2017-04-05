module ObjectivesHelper
	def objective_owner_name objective
		if objective.user_objectives.present?
			objective_user = objective.user_objectives.where(owner: true).first
			if objective_user.present?
				user = objective_user.user
				user.present? ? user.fullname : "N/A"
			else
				"N/A"
			end
		else
			"N/A"
		end
	end
end
