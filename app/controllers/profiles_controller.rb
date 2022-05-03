class ProfilesController < ApplicationController
	before_action :check_profile_presence, except: [:new, :create]
	before_action :check_isdisabled, except: [:create, :edit, :update, :destroy]
	before_action :set_profile, only: [:show, :edit, :update, :destroy, :media, :following, :followers, :settings]
	before_action :check_if_blocked, only: [:show]
	before_action :check_age_difference, only: [:show]
	before_action :require_same_user, only: [:edit, :update, :destroy, :settings]

	def show
		@full_page = true
		@profile_posts = @profile.posts.paginate(page: params[:page], per_page: 15) 
		
		@following_matches = Profile.notblocked(current_user.profile.blocking.ids, current_user.profile.blockers.ids).where(id: @profile.following.ids).joins(:tags).where(tags: {id: current_user.profile.tags.ids}).distinct.limit(8)
		@follower_matches = Profile.notblocked(current_user.profile.blocking.ids, current_user.profile.blockers.ids).where(id: @profile.followers.ids).joins(:tags).where(tags: {id: current_user.profile.tags.ids}).distinct.limit(8)
		@profile_images = Post.where(profile_id: @profile.id).where.not(image: [nil, '']).limit(9)
		
	end

	def new
		if Profile.exists?(user_id: current_user.id)
    	redirect_back fallback_location: posts_path	
    end

		@profile = Profile.new
	end

	def edit
		
	end

	def create
		@profile = Profile.new(profile_params)
  	@profile.user_id = current_user.id
  	@profile.age = current_user.age(current_user.dob)

  	if @profile.save
  		flash[:notice] = "Next you need tags."
      redirect_to new_tag_path
    else
      render 'new'
    end
	end

	def update
	 	respond_to do |format|
			if @profile.update(profile_params)
				format.html { redirect_to request.referer, notice: "Your profile was updated." }
				format.js 
				
			else
				format.html { redirect_to request.referer, alert: "There was a problem." }
			end
		end
	end
	
	def destroy
    @profile.destroy
    redirect_to profiles_path
	end

	def media
		@profile_image = Post.where(profile_id: @profile.id).where.not(image: [nil, '']).paginate(page: params[:page], per_page: 15)
	end

	def following
		@profile_following = Profile.notblocked(current_user.profile.blocking.ids, current_user.profile.blockers.ids).where(id: @profile.following.ids).joins(:tags).where(tags: {id: current_user.profile.tags.ids}).distinct.paginate(page: params[:page], per_page: 15)
		
	end

	def followers
		@profile_followers = Profile.notblocked(current_user.profile.blocking.ids, current_user.profile.blockers.ids).where(id: @profile.followers.ids).joins(:tags).where(tags: {id: current_user.profile.tags.ids}).distinct.paginate(page: params[:page], per_page: 15)
	end

	private
    
  def set_profile
  	@profile = Profile.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
    params.require(:profile).permit(:name, :headline, :about, :age, :searchingfor, :location, :ethnicity, :relationship, :sexuality, :height, :religion, :education, :bodytype, :eyecolor, :haircolor, :living, :kids, :smoking, :drinking, :language, :private, :private_tags, :isdisabled, :image1, :image2, :image3, :image4, :remove_image1, :remove_image2, :remove_image3, :remove_image4, keyword_ids: [])
  end

  #checks if signed in user is the same as profile owner
  def require_same_user
  	if current_user != @profile.user
      redirect_back(fallback_location: root_path)
    end
  end

  def check_if_blocked
  	redirect_back(fallback_location: root_path) unless !@profile.blocking?(current_user.profile) && (!@profile.isdisabled || @profile.user == current_user) 
  end

  def check_age_difference
  	redirect_back(fallback_location: root_path) unless @profile.user.isunderage == current_user.isunderage
  end 

end