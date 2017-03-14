namespace :default_userboards do
  desc "Create default userboards for existing users"
  task create_userboard: :environment do
  	User.all.each do |user|
  		if user.userboards.empty? 
  			type_t = user.userboards.build(name: "Today", userboard_type: "T", color: "#C0ED92", status: true)
	  		type_o = user.userboards.build(name: "Today", userboard_type: "O", color: "#C0ED92", status: true)	
  			Userboard.transaction do
	  			type_t.save
	  			type_o.save
  			end
  		end
  	end
  end

end
