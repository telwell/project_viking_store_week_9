module Admin::OrdersHelper

	# Get total value for a particular order_id
	def total_order_value(order_id)
		Order.select("SUM(price * quantity) AS total_revenue").
		where("order_id = #{order_id}").
		joins("JOIN products ON order_contents.product_id = products.id JOIN order_contents ON orders.id = order_contents.order_id").
		first.total_revenue
	end

	def order_item_quantity(order_id)
		Order.select("SUM(quantity) AS total_quantity").
		where("order_id = #{order_id}").
		joins("JOIN products ON order_contents.product_id = products.id JOIN order_contents ON orders.id = order_contents.order_id").
		first.total_quantity
	end

	def is_order_placed?(order)
		order.checkout_date.present? ? "Placed" : "Unplaced"
	end
end
