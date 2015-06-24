class CategoriesController < ApplicationController
	layout "admin"

	def index
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
			redirect_to categories_path
		else
			flash.now[:error] = "There were errors with your submission, try again."
			render :new
		end
	end

	def show
		@category = Category.find(id = params[:id])
	end

	def edit
		@category = Category.find(id = params[:id])
	end

	def update
		@category = Category.find(id = params[:id])
		@category.name = params[:category][:name]
		@category.description = params[:category][:description]
		if @category.save
			flash[:success] = "Category successfully updated!"
			redirect_to categories_path
		else
			flash.now[:error] = "There were problems with your update, please fix"
			render :edit
		end
	end
end
