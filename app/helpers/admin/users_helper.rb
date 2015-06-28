module Admin::UsersHelper

	def has_cart?(user)
		if user.orders.where("checkout_date IS null").present?
			user.orders.where("checkout_date IS null")
		else
			false
		end
	end

	def user_shipping_address(user)
		if user.shipping_id
			[Address.find(user.shipping_id).street_address, user.shipping_id]
		else
			"Shipping Not Set"
		end
	end

	def user_billing_address(user)
		if user.billing_id
			[Address.find(user.billing_id).street_address, user.billing_id]
		else
			"Billing Not Set"
		end
	end

	def disable_address_field?
		action_name == "new" ? true : false
	end

end
