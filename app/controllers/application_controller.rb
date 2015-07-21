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

	def add_product_to_cart(product_id)
		# Add a product to the cart or setup a new cart session with this product (product_id => quantity)
		if session[:cart]
			if session[:cart][product_id]
				# Item already exists in cart
				session[:cart][product_id] += 1
			else
				# Item isn't currently in cart
				session[:cart][product_id] = 1
			end
		else
			session[:cart] = { product_id => 1 }
		end
		# Really no reason this won't fail since we're just using a session...
		flash[:success] = "Product added to cart successfully!"
	end

	def merge_temp_cart(user)
		fails
	end

	# User login methods below ---------
	def sign_in(user)
		session[:current_user_id] = user.id
		current_user = user
	end

	def sign_out
		session.delete(:current_user_id) && current_user = nil
	end

	def current_user
		return nil unless session[:current_user_id]
		@current_user ||= User.find(session[:current_user_id])
	end
	helper_method :current_user

	def current_user=(user)
		@current_user = user
	end

	def signed_in_user?
		!!current_user
	end
	helper_method :signed_in_user?

end
