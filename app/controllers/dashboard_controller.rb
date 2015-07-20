class DashboardController < ApplicationController

	def index
		# This is just a ternary on a few lines
		@products = ( params[:filter_category] ? 
											Product.where("category_id = ?", params[:filter_category]).paginate(:page => params[:page], :per_page => 9) : 
											Product.all.paginate(:page => params[:page], :per_page => 9) )
		
		# This is in Application Controller
		add_product_to_cart(params[:add_product]) if params[:add_product]
	end
	
end