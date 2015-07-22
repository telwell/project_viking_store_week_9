class AdminController < ApplicationController
	before_filter :require_login

	def index
		#Nothing to do here right now.
	end
	
end