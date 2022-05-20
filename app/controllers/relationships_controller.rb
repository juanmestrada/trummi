class RelationshipsController < ApplicationController
	before_action :check_profile_presence
	before_action :check_age_difference, only: [:create]
	before_action :check_isdisabled

	def index	
		# @profiles = Profile.notdisabled.where(id: current_user.profile.following.ids).order(:name).paginate(page: params[:page], per_page: 1)
		@relationships = current_user.profile.following.where(isdisabled: false).order(:name).paginate(page: params[:page], per_page: 15)
	end

	def create
		current_user.profile.follow(@profile)
	end

	def destroy
		@profile = Relationship.find(params[:id]).followed
		current_user.profile.unfollow(@profile)
	end

	private

	def check_age_difference
		@profile = Profile.find(params[:followed_id])
    	redirect_back(fallback_location: root_path) unless @profile.user.isunderage == current_user.isunderage
    end

end