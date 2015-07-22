class UsersController < ApplicationController

	def new
		@user ||= User.new
	end

	def create
		if User.create(whitelisted_user_params).valid?
			@user = User.create(whitelisted_user_params)
			params[:user][:addresses_attributes].each_with_index do |address, i|
				set_address_ids(@user, address[1], params, i)
			end
			flash[:success] = "User created successfully"
			sign_in(@user)
			redirect_to root_path
		else
			flash[:error] = "Failed to create user"
			render :new
		end
	end

private
	def whitelisted_user_params
		params.require(:user).
			permit(:first_name,
						 :last_name,
             :email,
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
