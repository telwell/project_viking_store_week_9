class UsersController < ApplicationController
	include UsersHelper

	def new
		@user ||= User.new
		@addresses = [Address.new, Address.new]
	end

	def create
		if User.new(whitelisted_user_params).valid?
			@user = User.create(whitelisted_user_params)
			flash[:success] = "User created successfully. Please set default shipping and billing addresses!"
			sign_in(@user)
			redirect_to edit_user_path
		else
			flash[:error] = "Failed to create user"
			render :new
		end
	end

	def edit
		current_user
		@addresses = @current_user.addresses
		@addresses << Address.new
	end

	def update
		current_user
		if @current_user.update(whitelisted_user_params)
			flash[:success] = "User updated successfully"
			set_user_addresses(params, @current_user)
			redirect_to root_path
		else
			flash[:error] = "User could not be updated"
			render :edit
		end
	end

	def destroy
		current_user
		if @current_user.destroy
			flash[:success] = "Successfully deleted user."
			sign_out
			redirect_to root_path
		else
			flash[:error] = "Aliens stopped us from deleting this user, HELP!"
			render :edit
		end
	end

private
	def whitelisted_user_params
		params.require(:user).
			permit(:first_name,
						 :last_name,
             :email,
             :addresses_attributes => [
             		:street_address,
             		:city_id, 
             		:state_id,
             		:zip_code, 
             		:id, 
             		:_destroy
             ],
             :credit_card_attributes => [
		           		:card_number,
		           		:exp_month,
		           		:exp_year
		         ]
			)
	end
end