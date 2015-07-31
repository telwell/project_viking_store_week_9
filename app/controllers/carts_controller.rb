class CartsController < ApplicationController
	before_filter :require_address_ids_carts
	before_filter :current_user

	def edit
		@cart_order = find_cart(@current_user)
	end	

	def show
		@cart_order = find_cart(@current_user)
		@credit_card = (@cart_order.credit_card ? @cart_order.credit_card : CreditCard.new)
	end

end
