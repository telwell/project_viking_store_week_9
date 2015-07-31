class CheckoutsController < ApplicationController
	before_filter :require_valid_credit_card

	def update
		current_user
		if @current_user.update(whitelisted_checkout_params)
			@cart_order = find_cart(@current_user)
			@cart_order.update(:checkout_date => Time.now.utc)
			@cart_order.update(:shipping_id => params[:default_ids][:shipping_id], :billing_id => params[:default_ids][:billing_id])
			create_new_cart(@current_user)
			flash[:success] = "Checkout Success!"
			redirect_to root_path
		else
			@cart_order = find_cart(@current_user)
			@credit_card = @current_user.credit_card
			flash[:error] = "There were errors checking out."
			render '/carts/show'
		end
	end

private
	def whitelisted_checkout_params
		params.require(:order).
				permit( :id,
								:shipping_id, 
								:billing_id,
		            :credit_card_attributes => [
		            	:id,
		           		:card_number,
		           		:exp_month,
		           		:exp_year
		           ]
				)
	end
end
