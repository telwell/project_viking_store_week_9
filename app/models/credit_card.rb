class CreditCard < ActiveRecord::Base
	has_many :orders
	belongs_to :users
end
