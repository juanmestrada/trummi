class InterstitialsController < ApplicationController
	before_action :check_profile_presence, except: [:screen]

	def screen
		
	end

end