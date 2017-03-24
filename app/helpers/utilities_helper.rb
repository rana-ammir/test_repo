module UtilitiesHelper

def report_for_dropdown(options)
	if options.present?
		if options.first.class.name == "User"
			options.map{ |option| [option.fullname, option.id] }
		else
			options.map{ |option| [option.name, option.id] }
		end	
	end
end

end
