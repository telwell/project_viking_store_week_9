class Category < ActiveRecord::Base
	has_many :products
	belongs_to :order
	has_many :orders, through: :products
end
