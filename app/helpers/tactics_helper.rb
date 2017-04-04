module TacticsHelper
	def tactic_owner_name tactic
		if tactic.user_tactics.present?
			user = tactic.user_tactics.where(owner: true).first.user
			user.present? ? user.fullname : "N/A"
		else
			"N/A"
		end
	end
end
