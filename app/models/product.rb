class Product < ActiveRecord::Base
	belongs_to :category
	has_many :orders, through: :order_contents
	has_many :order_contents, class_name: "OrderContents"
	has_many :users_who_bought, class_name: "User", foreign_key: "user_id", source: :user , through: :orders

	validates :name, :sku, :description, :price, :category_id, :presence => true
	validates :price, :numericality => { :less_than_or_equal_to => 10_000 }
	validates :category, :presence => true
	
	# TODO: Check out inclusion validator and see why this breaks rake db:seed
	#####validates :category_id, inclusion: { in: Category.pluck(:id) }
	# TODO: Look up filters in rails and how to use them

	def self.total_product
		# Allow us to pass in a block which will get the rows in a 
		# particular timeframe.
		if block_given?
			in_timeframe = yield
			in_timeframe.count
		else
			Product.count
		end
	end
end
