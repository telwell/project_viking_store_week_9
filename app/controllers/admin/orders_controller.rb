class Admin::OrdersController < AdminController

	def index
		@orders = Order.all.limit(100)
	end

end
