module StrategiesHelper
	def strategy_owner_name strategy
		if strategy.user_strategies.present?
			user = strategy.user_strategies.where(owner: true).first.user
			user.present? ? user.fullname : "N/A"
		else
			"N/A"
		end
	end
end
