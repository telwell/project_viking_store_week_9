class DashboardController < ApplicationController

	def index
		current_user
		# This is just a ternary on a few lines
		@products = ( params[:filter_category] ? 
											Product.where("category_id = ?", params[:filter_category]).paginate(:page => params[:page], :per_page => 9) : 
											Product.all.paginate(:page => params[:page], :per_page => 9) )
		
		# If there's a signed in user then add the product to their current cart
		# otherwise add it to the session cart
		if signed_in_user?
			add_product_to_cart(@current_user, params[:add_product]) if params[:add_product]
		else
			add_product_to_session_cart(params[:add_product]) if params[:add_product] #In Application Controller
		end
	end
	
end