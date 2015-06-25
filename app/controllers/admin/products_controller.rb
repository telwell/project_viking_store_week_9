class Admin::ProductsController < ApplicationController
	layout "admin" 

	def index
		@products = Product.all
	end

end
