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

	def new
		@order = Order.new
		@user = User.find(params[:user_id])
		@credit_card = CreditCard.where("user_id = ?", params[:user_id])
	end

	def create
		@order = Order.new(whitelisted_order_params)
		if @order.save 
			flash[:success] = "Order added successfully!"
			redirect_to edit_admin_order_path(@order.id)
		else
			render :new
		end
	end

	def edit
		@order = Order.find(params[:id])
		@user = @order.user
	end

private 

	def whitelisted_order_params
		params.require(:order).permit(:shipping_id, :billing_id, :user_id)
	end
end
