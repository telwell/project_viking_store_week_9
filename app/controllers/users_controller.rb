class UsersController < ApplicationController
	include UsersHelper

	def new
		@user ||= User.new
		@addresses = [Address.new, Address.new]
	end

	def create
		if User.new(whitelisted_user_params).valid?
			@user = User.create(whitelisted_user_params)
			flash[:success] = "User created successfully"
			sign_in(@user)
			redirect_to root_path
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


	def set_address_ids(user, address, user_params, index)
		# QUESTION: Trying to set the shipping_id and billing_id for this particular user
		# first_address_type
		if index == 0
			address_type = ( user_params[:first_address_type] == "billing" ? :billing_id : :shipping_id )
			new_address = Address.create(:user_id => user.id, :street_address => address[:street_address], :city_id => address[:city_id], :state_id => address[:state_id], :zip_code => address[:zip_code])
			user.update( address_type => new_address.id )
		# second_address_type
		elsif index == 1
			address_type = ( user_params[:second_address_type] == "billing" ? :billing_id : :shipping_id )
			new_address = Address.create(:user_id => user.id, :street_address => address[:street_address], :city_id => address[:city_id], :state_id => address[:state_id], :zip_code => address[:zip_code])
			user.update( address_type => new_address.id )
		end
	end
end
