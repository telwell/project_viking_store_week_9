class Category < ActiveRecord::Base
	has_many :products, dependent: :nullify
	belongs_to :order
	has_many :orders, through: :products

	validates :name, presence: true, length: {in: 4..16}
	validates :description, presence: true

end
