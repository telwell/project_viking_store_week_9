class Admin::OrdersController < AdminController

	def index
		save_referer_to_session
		if check_search_user
			@valid_search_user = true
			@orders = User.find(params[:search_user_id]).orders
		else
			@valid_search_user = false
			@orders = Order.all.limit(100)
		end
	end

	def show
		save_referer_to_session
		@order = Order.find(params[:id])
		@shipping_address = Address.find(@order.shipping_id)
		@billing_address = Address.find(@order.billing_id)
		@credit_card = CreditCard.where("user_id = #{@order.user_id}").first
		@order_items = OrderContents.where("order_id = #{@order.id}")
	end

	def new
		save_referer_to_session
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
		save_referer_to_session
		@order = Order.find(params[:id])
		@user = @order.user
		@order_contents = OrderContents.where("order_id = ?", params[:id])
		@new_order_content = OrderContents.new
	end

	def update
		@order = Order.find(params[:id])
		if @order.checkout_date.nil? && params[:order][:order_status] == "placed"
			@order.checkout_date = Time.now
		end
		if @order.update(whitelisted_order_params)
			flash[:success] = "Order updated successfully!"
			redirect_to admin_orders_path(:search_user_id => params[:order][:id])
		else
			render :new
		end
	end

	def destroy
		@order = Order.find(params[:id])
		if @order.destroy
			flash[:success] = "Order deleted successfully!"
			redirect_to admin_orders_path(:search_user_id => params[:order][:user_id])
		else
			redirect_to session.delete(:return_to)
		end
	end

private 

	def whitelisted_order_params
		params.require(:order).permit(:shipping_id, :billing_id, :user_id, :checkout_date)
	end
end
