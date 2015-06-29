class Admin::AddressesController < AdminController

	def index
		if check_search_user
			@valid_search_user = true
			@addresses = User.find(params[:search_user_id]).addresses
		else
			@valid_search_user = false
			@addresses = Address.all
		end
	end

	def show
		@address = Address.find(params[:id])
	end


private
	
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
