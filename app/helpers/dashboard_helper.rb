module DashboardHelper
	# Return true if user has a cart in their current session
	def has_cart?
		session[:cart] ? true : false
	end
	
end
