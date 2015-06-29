module Admin::AddressesHelper

	# Index page title will be different if user is searched
	def generate_address_index_title(search_user_id, valid_search_user)
		if valid_search_user
			user = User.find(search_user_id)
			"#{user.first_name} #{user.last_name}'s Addresses:"
		else
			"Addresses:"
		end
	end
end
