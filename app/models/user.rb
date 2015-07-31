class User < ActiveRecord::Base
	has_many :addresses, dependent: :destroy
	accepts_nested_attributes_for :addresses, 
                                :reject_if => :all_blank, 
                                :allow_destroy => :true
	has_many :cities
	has_many :states
	has_one :credit_card, dependent: :destroy
	has_many :orders
	has_many :products, through: :order_contents
	has_many :order_contents, through: :orders
	belongs_to :shipping_address, foreign_key: :shipping_id, class_name: "Address", dependent: :destroy  
	belongs_to :billing_address, foreign_key: :billing_id, class_name: "Address", dependent: :destroy  
	
	accepts_nested_attributes_for :credit_card, 
                                :allow_destroy => :true

	# Make sure that we delete the cart when a user is deleted but not
	# any orders that have been completed.
	after_destroy :cleanup_cart

	validates :first_name, :last_name, :email, :presence => true, length: {in: 1..64}
	#validates :credit_card, presence: { scope: :order }, :on => :update

	def self.total

		# Allow us to pass in a block which will get the rows in a 
		# particular timeframe.
		if block_given?
			in_timeframe = yield
			in_timeframe.count
		else
			User.count
		end
		
	end


	# Get the 3 states that have the highest 
	# number of clients based on our billing addresses.
	def self.top_states

		select("states.name AS name, COUNT(*) AS client_total ").
		joins("JOIN addresses ON users.billing_id = addresses.id JOIN states ON addresses.state_id = states.id").
		where("billing_id IS NOT null").
		group("states.name").
		order("client_total DESC").
		limit(3)

	end


	# Get the 3 cities that have the greatest 
	# number of clients based on our billing addresses.
	def self.top_cities

		select("cities.name AS name, COUNT(*) AS client_total ").
		joins("JOIN addresses ON users.billing_id = addresses.id JOIN cities ON addresses.city_id = cities.id").
		where("billing_id IS NOT null").
		group("cities.name").
		order("client_total DESC").
		limit(3)

	end

private
	def cleanup_cart
		Order.where("user_id = #{self.id}").destroy_all("checkout_date IS null")
	end

end