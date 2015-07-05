class Admin::OrdersController < AdminController

	def index
		if check_search_user
			@valid_search_user = true
			@orders = User.find(params[:search_user_id]).orders
		else
			@valid_search_user = false
			@orders = Order.all.limit(100)
		end
	end

end
