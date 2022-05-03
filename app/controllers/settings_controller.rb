class SettingsController < ApplicationController
	before_action :check_profile_presence

	def index
		@profile = current_user.profile
	end

	def blocked
		@profile = current_user.profile
		
		@blocked = current_user.profile.blocking.paginate(page: params[:page], per_page: 15)
	end

	def remove
    	@profile = current_user.profile
  	end

	def disable_account
		@profile = current_user.profile
	end

	def delete_account
		@profile = current_user.profile
	end

end 