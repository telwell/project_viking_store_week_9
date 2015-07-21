class SessionsController < ApplicationController

	def new
		# silence is golden 
	end

	def create
		if User.find_by_email(params[:email])
			sign_in(User.find_by_email(params[:email]))
			current_user
			# We want to merge the temporary cart with anything the user already has stored in the DB
			merge_temp_cart(@current_user)
			flash[:success] = "#{@current_user.first_name} #{@current_user.last_name} logged in successfully!"
			redirect_to root_path
		else
			flash[:error] = "Invalid user, could not login!"
			redirect_to root_path
		end
	end

	def destroy
		sign_out
		flash[:success] = "Logged out successfully."
		redirect_to root_path
	end

end
