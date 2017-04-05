module StrategiesHelper
	def strategy_owner_name strategy
		if strategy.user_strategies.present?
			strategy_user = strategy.user_strategies.where(owner: true).first
			if strategy_user.present?
				user = strategy_user.user
				user.present? ? user.fullname : "N/A"
			else
				"N/A"
			end
		else
			"N/A"
		end
	end
end
