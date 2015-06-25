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

	def new
		@product = Product.new
		@categories = Category.all
	end

	def create
		@product = Product.new(whitelisted_product_params)
		@categories = Category.all
		# This below is to make sure that our category is actually in the list of categories
		if @categories.map{|category| category.id }.include?(params[:product][:category_id].to_i) && @product.save 
			flash[:success] = "Product created successfully!"
			redirect_to admin_products_path
		else
			render :new
		end
	end

	def edit
		@product = Product.find(id = params[:id])
		@categories = Category.all
	end

	def update
		@product = Product.find(id = params[:id])
		whitelisted_product_params.each do |key, value|
			@product[key] = value
		end
		@categories = Category.all
		# This below is to make sure that our category is actually in the list of categories
		if @categories.map{|category| category.id }.include?(params[:product][:category_id].to_i) && @product.save 
			flash[:success] = "Product created successfully!"
			redirect_to admin_products_path
		else
			render :new
		end
	end

	def destroy
		@product = Product.find(id = params[:id])
		if @product.destroy
			flash[:success] = "Product deleted successfully!"
			redirect_to admin_products_path
		else

		end
	end

private
	# Since a product may not have a category I wanted to add a default 
	# in case there was nothing set. 
	def category_name(product)
		product.category ? product.category.name : "Category not set"
	end

	def whitelisted_product_params
		params.require(:product).permit(:name, :sku, :description, :price, :category_id)
	end
end
