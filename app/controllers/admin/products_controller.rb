class Admin::ProductsController < AdminController

	def index
		save_referer_to_session
		@products = Product.all
	end

	def show
		save_referer_to_session
		@product = Product.find(params[:id])
		@category = category_name(@product)
		@orders = @product.orders.where.not(checkout_date: nil).count
		@carts = @product.orders.where(checkout_date: nil).count
	end

	def new
		@product = Product.new
		@categories = Category.all
	end

	def create
		@product = Product.new(whitelisted_product_params)
		@categories = Category.all
		if @product.save 
			flash[:success] = "Product created successfully!"
			redirect_to admin_products_path
		else
			render :new
		end
	end

	def edit
		save_referer_to_session
		@product = Product.find(params[:id])
		@categories = Category.all
	end

	def update
		@product = Product.find(params[:id])
		@categories = Category.all
		if @product.update(whitelisted_product_params)
			flash[:success] = "Product created successfully!"
			redirect_to admin_products_path
		else
			render :new
		end
	end

	def destroy
		@product = Product.find(params[:id])
		if @product.destroy
			flash[:success] = "Product deleted successfully!"
			redirect_to admin_products_path
		else
			redirect_to session.delete(:return_to)
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
