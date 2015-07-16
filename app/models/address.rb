class Address < ActiveRecord::Base
	belongs_to :user
	belongs_to :city
	belongs_to :state
	has_one :shipping_user, foreign_key: :shipping_id, class_name: "User", dependent: :nullify 
	has_one :billing_user, foreign_key: :billing_id, class_name: "User", dependent: :nullify

	validates :street_address, :zip_code, :state_id, :city_id, :user_id, :presence => true
end
