class City < ActiveRecord::Base
	belongs_to :users
	has_many :addresses
end
