class Admin::AddressesController < AdminController

	def index
		save_referer_to_session
		if check_search_user
			@valid_search_user = true
			@addresses = User.find(params[:search_user_id]).addresses
		else
			@valid_search_user = false
			@addresses = Address.all
		end
	end

	def show
		save_referer_to_session
		@address = Address.find(params[:id])
	end

	def new
		@address = Address.new
	end

	def create
		@address = Address.new(whitelisted_address_params)
		if @address.save 
			flash[:success] = "Address added successfully!"
			redirect_to admin_addresses_path(:search_user_id => params[:address][:user_id])
		else
			render :new
		end
	end

	def edit
		save_referer_to_session
		@address = Address.find(params[:id])
	end

	def update
		@address = Address.find(params[:id])
		if @address.update(whitelisted_address_params)
			flash[:success] = "Address updated successfully!"
			redirect_to admin_addresses_path(:search_user_id => params[:address][:user_id])
		else
			render :new
		end
	end

	def destroy
		@address = Address.find(params[:id])
		if @address.destroy
			flash[:success] = "Address deleted successfully!"
			redirect_to admin_addresses_path
		else
			redirect_to session.delete(:return_to)
		end
	end

private
	
	def whitelisted_address_params
		params.require(:address).permit(:street_address, :zip_code, :city_id, :state_id, :user_id)
	end

	# Check the search_user_id param to see if it's valid
	def check_search_user
		if params[:search_user_id]
			if User.pluck(:id).include?(params[:search_user_id].to_i)
				true
			else
				flash[:notice] = "User submitted is not valid"
				false
			end
		else
			false
		end
	end
end
