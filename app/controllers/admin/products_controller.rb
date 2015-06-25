class Admin::ProductsController < ApplicationController
	layout "admin" 

	def index
		@products = Product.all
	end

	def show
		@product = Product.find(id = params[:id])
		@category = category_name(@product)
		@orders = @product.orders.where("checkout_date IS NOT null").count
		@carts = @product.orders.where("checkout_date IS null").count
	end

private 
	def category_name(product)
		product.category ? product.category.name : "Category not set"
	end
end
