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
end
