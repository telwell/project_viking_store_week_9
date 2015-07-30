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
