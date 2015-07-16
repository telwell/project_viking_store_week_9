class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def save_referer_to_session
		session[:return_to] ||= request.referer
	end

	def save_user_to_session(user_id)
		session[:user_id] ||= user_id
	end

	# Check the search_user_id param to see if it's valid
	
	# TODO: Change name to valid_search_user? in all instances
	# If it's true/false always end it in a question mark
	def check_search_user
		if params[:search_user_id]
			if User.pluck(:id).include?(params[:search_user_id].to_i)
				true
			else
				flash[:notice] = "User submitted is not valid"
				false
			end
		else
			false
		end
	end

end
