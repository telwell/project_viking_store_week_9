class Admin::AddressesController < AdminController

	def index
		@addresses =(check_search_user ? User.find(params[:search_user_id]).addresses : Address.all)
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
