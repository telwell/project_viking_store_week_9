module ApplicationHelper
	def bootstrap_error_class(key)
		if key == "error"
			"bg-danger"
		elsif key == "notice"
			"bg-warning"
		elsif key == "success"
			"bg-success"
		else
			"bg-info"
		end
	end

	# Incorporate the User's first and last name in the title for the 
	# Address and Order filter pages.
	def generate_index_title(search_user_id, valid_search_user)
		if valid_search_user
			user = User.find(search_user_id)
			"#{user.first_name} #{user.last_name}'s #{controller_name.titleize}:"
		else
			"#{controller_name.titleize}:"
		end
	end
end
