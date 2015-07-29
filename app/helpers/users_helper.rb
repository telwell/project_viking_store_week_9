module UsersHelper

	def is_default_shipping?(id)
		@current_user.shipping_id == id ? true : false
	end

	def is_default_billing?(id)
		@current_user.billing_id == id ? true : false
	end

	def set_user_addresses(params, user)
		
		if params[:default_billing]
			user.update(:billing_id => params[:default_billing])
		end

		if params[:default_shipping]
			user.update(:shipping_id => params[:default_shipping])
		end

	end
end
