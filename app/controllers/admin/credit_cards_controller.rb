class Admin::CreditCardsController < AdminController

	def destroy
		@credit_card = CreditCard.find(params[:id])
		if @credit_card.destroy
			flash[:success] = "Product deleted successfully!"
			redirect_to admin_user_path(session.delete(:user_id))
		else
			redirect_to session.delete(:return_to)
		end
	end

end
