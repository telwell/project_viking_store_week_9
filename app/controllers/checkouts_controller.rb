class CheckoutsController < ApplicationController

	def update
		current_user
		@cart_order = find_cart(@current_user)
		if @cart_order.user.update(whitelisted_checkout_params)
			@cart_order.update(:checkout_date => Time.now.utc)
			create_new_cart(@current_user)
			flash[:success] = "Checkout Success!"
			redirect_to root_path
		else
			flash[:error] = "There were errors checking out."
			redirect_to cart_path
		end
	end

private
	def whitelisted_checkout_params
		params.require(:order).
				permit(:id,
		           :credit_card_attributes => [
		           		:card_number,
		           		:exp_month,
		           		:exp_year
		           ]
				)
	end
end
