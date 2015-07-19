class DashboardController < ApplicationController

	def index
		@products = Product.all.limit(9)
	end

end