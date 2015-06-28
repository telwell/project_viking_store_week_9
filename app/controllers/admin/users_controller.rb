class Admin::UsersController < AdminController

	def index
		save_referer_to_session
		# We're saving the user ID here because if we click the delete CC info 
		# button on this page we need that information saved.
		save_user_to_session(params[:id])
		@users = User.all
	end

	def show
		save_referer_to_session
		save_user_to_session(params[:id])
		@user = User.find(params[:id])
		@user_addresses = @user.addresses
		@user_credit_card = CreditCard.where("user_id = #{params[:id]}").first
		@orders = @user.orders
	end

	def new
		save_referer_to_session
		@user = User.new
	end

	def create
		@user = User.new(whitelisted_user_params)
		if @user.save 
			flash[:success] = "User created successfully!"
			redirect_to admin_user_path(@user.id)
		else
			render :new
		end
	end

	def edit
		save_referer_to_session
		save_user_to_session(params[:id])
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(whitelisted_user_params)
			flash[:success] = "User saved successfully!"
			redirect_to admin_user_path(@user.id)
		else
			render :new
		end
	end

	def destroy
		@user = User.find(params[:id])
		if @user.destroy
			flash[:success] = "User deleted successfully!"
			redirect_to admin_users_path
		else
			redirect_to session.delete(:return_to)
		end
	end

private 
	def whitelisted_user_params
		params.require(:user).permit(:first_name, :last_name, :email, :billing_id, :shipping_id)
	end
end
