class DashboardController < ApplicationController

	def index
		@products = Product.all.paginate(:page => params[:page], :per_page => 9)
	end

end