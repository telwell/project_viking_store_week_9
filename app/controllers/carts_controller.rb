class CartsController < ApplicationController

	def edit
		current_user
		@cart_order = find_cart(@current_user)
	end	

	def show
		current_user
		@cart_order = find_cart(@current_user)
		@credit_card = (@cart_order.credit_card ? @cart_order.credit_card : CreditCard.new)
	end

end
