class Admin::CategoriesController < AdminController

	def index
		save_referer_to_session
		@categories = Category.all
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new
		@category.name = params[:category][:name]
		@category.description = params[:category][:description]
		if @category.save
			flash[:success] = "Successfully created new category!"
			redirect_to admin_categories_path
		else
			flash.now[:error] = "There were errors with your submission, try again."
			render :new
		end
	end

	def show
		save_referer_to_session
		@category = Category.find(params[:id])
	end

	def edit
		save_referer_to_session
		@category = Category.find(params[:id])
	end

	def update
		@category = Category.find(params[:id])
		@category.name = params[:category][:name]
		@category.description = params[:category][:description]
		if @category.save
			flash[:success] = "Category successfully updated!"
			redirect_to admin_categories_path
		else
			flash.now[:error] = "There were problems with your update, please fix"
			render :edit
		end
	end

	def destroy
		@category = Category.find(params[:id])
		if @category.destroy
			flash[:success] = "Category successfully deleted!"
			redirect_to admin_categories_path
		else
			flash[:error] = "Couldn't delete this category, please try again"
			redirect_to session.delete(:return_to)
		end
	end

	#TODO: Add whitelisted_categories_params to be used in update method. Don't set everything
	# manually there.
end
