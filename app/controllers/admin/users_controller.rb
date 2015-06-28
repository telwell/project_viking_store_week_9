class Admin::UsersController < AdminController

	def index
		save_referer_to_session
		@users = User.all
	end

	def show
		save_user_to_session(params[:id])
		@user = User.find(params[:id])
		@user_addresses = @user.addresses
		@user_credit_card = CreditCard.where("user_id = #{params[:id]}").first
		@orders = @user.orders
	end

end
