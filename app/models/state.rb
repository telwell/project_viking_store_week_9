class State < ActiveRecord::Base
	belongs_to :users
	has_many :addresses
end
