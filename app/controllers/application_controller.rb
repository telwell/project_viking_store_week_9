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
end
