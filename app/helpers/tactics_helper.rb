module TacticsHelper
	def tactic_owner_name tactic
		if tactic.user_tactics.present?
			tactic_user = tactic.user_tactics.where(owner: true).first
			if tactic_user.present?
				user = tactic_user.user
				user.present? ? user.fullname : "N/A"
			else
				"N/A"
			end
		else
			"N/A"
		end
	end
end
