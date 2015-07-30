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


	# User login methods below
	def sign_in(user)
		session[:current_user_id] = user.id
		current_user = user
		create_new_cart(user) unless has_cart?(user)
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

	# Cart methods and logic below
	
	# Returns true if the user passed has an order w/o a checkout date
	def has_cart?(user)
		if user.orders.first.nil?
			false
		elsif user.orders.order(:checkout_date).first.checkout_date.nil?
			true
		else
		 false
		end
	end

	def has_session_cart?
		!!session[:cart]
	end

	def add_product_to_session_cart(product_id)
		# Add a product to the session cart or setup a 
		# new session cart session with passed product (product_id => quantity)
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

	# Merge session cart with persisted cart if session cart exists
	# otherwise create an empty cart for this user. Destroys the 
	# session cart as well.
	def merge_temp_cart(user)
		# User has NO session cart AND NO persisted cart
		if !has_session_cart? && !has_cart?(user)
			create_new_cart(user)

		# User has session cart AND NO persisted cart
		elsif has_session_cart? && !has_cart?(user)
			order_id = create_new_cart(user)
			add_products_to_cart(order_id, session.delete(:cart))

		# Don't need to do anything if User has NO session cart AND persisted cart

		# User has session cart AND persisted cart
		elsif has_session_cart? && has_cart?(user)
			order_id = user.orders.first.id
			add_products_to_cart(order_id, session.delete(:cart))
		end
	end

	# Creates a new cart with nothing in it for the user
	def create_new_cart(user)
		order = Order.create(:user_id => user.id, :shipping_id => user.shipping_id, :billing_id => user.billing_id)
		order.id
	end

	# Adds a hash of product ID's to an order. Account for the edge case
	# where there's already a number of products in the cart from the session cart.
	def add_products_to_cart(order_id, products)
		products.each do |product_id, quantity|
			if OrderContents.where("order_id = ?", order_id).where("product_id = ?", product_id).exists?
				order = OrderContents.where("order_id = ?", order_id).where("product_id = ?", product_id).first
				order_quantity = order[:quantity]
				order.update(:quantity => order_quantity + quantity )
			else
				OrderContents.create(:order_id => order_id, :product_id => product_id, :quantity => quantity)
			end
		end
	end

	# Adds one item to the cart of a signed in user
	def add_product_to_cart(user, product_id)
		if has_cart?(user)
			order_id = user.orders.order(:checkout_date).first.id
			if OrderContents.where("order_id = ?", order_id).where("product_id = ?", product_id).exists?
				quantity = OrderContents.where("order_id = ?", order_id).where("product_id = ?", product_id).first.quantity
				OrderContents.where("order_id = ?", order_id).where("product_id = ?", product_id).first.update(:quantity => quantity+1)
			else
				OrderContents.create(:order_id => order_id, :product_id => product_id, :quantity => 1)
			end
			flash[:success] = "Product added to cart successfully!"
		end
	end

	# Get the current current cart for the user
	def find_cart(user)
		user.orders.where("checkout_date IS null").first
	end

	def require_login
		unless signed_in_user?
			flash[:error] = "You need to be logged in to access this page."
			redirect_to new_session_path
		end
	end

end
