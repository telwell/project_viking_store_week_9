class CreditCard < ActiveRecord::Base
	has_many :orders
	belongs_to :user

	validates :card_number, :exp_month, :exp_year, :presence => true
	
end
