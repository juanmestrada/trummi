class BlocksController < ApplicationController
	def index
		@profiles = Profile.where(user_id: current_user.profile.blocking.ids).paginate(page: params[:page], per_page: 15)
	end

	def create

		@profile = Profile.find(params[:blockee_id])
		current_user.profile.block(@profile)
		if current_user.profile.following?(@profile)
			current_user.profile.unfollow(@profile)
		end

		if @profile.following?(current_user.profile)
			@profile.unfollow(current_user.profile)
		end
		
	end

	def remove
		@profile = Profile.find(params[:id])
	end

	def destroy
		
		@profile = Block.find(params[:id]).blockee
		
		current_user.profile.unblock(@profile)	
		
    	if params[:view] == "unblock"
	        redirect_to profile_path(@profile)
	    end 
	    
	end

end