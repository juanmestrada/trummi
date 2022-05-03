class DashboardController < ApplicationController
	skip_before_action :authenticate_user!, only: [:welcome]

	def home
		new_user_session_path
	end

	def welcome
		
	end
 
end