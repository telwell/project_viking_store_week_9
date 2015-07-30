class CreditCardsController < ApplicationController

	def destroy
		current_user
		if @current_user.credit_card
			@current_user.credit_card.destroy
			flash[:success] = "Credit card deleted successfully."
			redirect_to '/cart#show'
		else
			flash[:error] = "Credit card not deleted, try again."
			redirect_to 'cart#show'
		end
	end
end
