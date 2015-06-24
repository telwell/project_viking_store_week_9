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
			flash[:success] = "Successfully created new category"
			redirect_to categories_path
		else
			flash.now[:error] = "There were errors with your submission, try again"
			render :new
		end
	end
end
