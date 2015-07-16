class DashboardController < ApplicationController

	def index
		@products = Product.all.limit(20)
	end

end