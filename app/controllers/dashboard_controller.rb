class DashboardController < ApplicationController
	before_filter :require_address_ids_dashboard

	def index
		current_user
		# Setting what products to show (using a paginate gem to help with many items)
		@products = ( params[:filter_category] ? 
											Product.where("category_id = ?", params[:filter_category]).paginate(:page => params[:page], :per_page => 9) : 
											Product.all.paginate(:page => params[:page], :per_page => 9) )
		
		# If there's a signed in user then add the product to their current cart
		# otherwise add it to the session cart
		if signed_in_user?
			unless has_cart?(@current_user)
				create_new_cart(@current_user) 
				merge_temp_cart(@current_user)
			end
			add_product_to_cart(@current_user, params[:add_product]) if params[:add_product]
		else
			add_product_to_session_cart(params[:add_product]) if params[:add_product] #In Application Controller
		end
	end
	
end