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

	def show
		@order = Order.find(params[:id])
		@shipping_address = Address.find(@order.shipping_id)
		@billing_address = Address.find(@order.billing_id)
		@credit_card = CreditCard.where("user_id = #{@order.user_id}").first
		@order_items = OrderContents.where("order_id = #{@order.id}")
	end

end
