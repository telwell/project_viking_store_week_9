class OrdersController < ApplicationController

	def update
		current_user
		@cart_order = find_cart(@current_user)
		if @cart_order.update(whitelisted_order_params)
			flash[:success] = "Order updated successfully"
			redirect_to edit_cart_path
		else
			flash[:error] = "User could not be updated"
			render :edit
		end
	end

	def destroy
		current_user
		cart = find_cart(@current_user)
		if cart.destroy
			flash[:success] = "Cart deleted successfully."
			create_new_cart(@current_user)
			redirect_to dashboard_index_path
		else
			flash[:error] = "Error deleting cart."
			render :show
		end
	end


	def whitelisted_order_params
		params.require(:order).
			permit( :id,
							:shipping_id,
							:billing_id,
	            :order_contents_attributes => [
	           		:quantity, 
	           		:id, 
	           		:_destroy
	           ]
			)
	end
end
