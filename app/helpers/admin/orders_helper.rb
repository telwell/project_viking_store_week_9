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
		order_status = []

		order_status[0]=(order.checkout_date.present? ? "Placed" : "Unplaced")

		# This will be used to format our CSS
		order_status[1]=(order_status[0] == "Placed" ? "status-placed" : "status-unplaced")

		order_status
	end
end
