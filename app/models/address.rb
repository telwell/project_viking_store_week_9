class Address < ActiveRecord::Base
	belongs_to :user
	belongs_to :city
	belongs_to :state

	validates :street_address, :zip_code, :state_id, :city_id, :user_id, :presence => true
end
