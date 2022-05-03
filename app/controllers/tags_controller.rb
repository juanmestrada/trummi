class TagsController < ApplicationController
	before_action :check_profile_presence
	before_action :check_isdisabled
	before_action :set_tag, only: [:remove, :show, :destroy]
	before_action :set_user_tags, only: [:index, :search]
	# before_action :require_same_user_t, only: [ :destroy]
	
	def index
		if !@taglist.empty?
			
			@q = Profile.where.not(id: current_user.profile.id).notblocked(current_user.profile.blocking.ids, current_user.profile.blockers.ids).ransack(name_start: params[:q], age_gteq: params[:min_age], age_lteq: params[:max_age], ethnicity_cont_all: params[:ethnicity], religion_cont_all: params[:religion], sexuality_cont_all: params[:sexuality], relationship_cont_all: params[:relationship], kids_cont_all: params[:kids], height_gt: params[:min_height], bodytype_cont_all: params[:bodytype], living_cont_all: params[:living], smoking_cont_all: params[:smoking], drinking_cont_all: params[:drinking], education_cont_all: params[:education], private_false: true, isdisabled_false: true, user_isunderage_true: current_user.isunderage, tags_name_cont_any: @taglist.split(', '))
			
			@match = @q.result(distinct: true).order(:name).paginate(page: params[:page], per_page: 15)
		end
		
	end

	def search
		if !@taglist.empty?
			
			@prof = Profile.notblocked(current_user.profile.blocking.ids, current_user.profile.blockers.ids).ransack(name_start: params[:q], private_false: true, isdisabled_false: true, user_isunderage_true: current_user.isunderage, tags_name_cont_any: @taglist.split(', ')).result(distinct: true).includes(:tags)
			
			@t = Tag.where(name: @taglist.split(', ')).ransack(name_start: params[:q] ).result(distinct: true).includes(:user_tags)
		
			respond_to do |format|
				format.html {}
				format.json {
					@t = @t.limit(10)
					
					if !@taglist.empty?
						@prof = @prof.limit(10)
					end
				}
			end
		end
	end

	def show
		@tag_profiles = Profile.notblocked(current_user.profile.blocking.ids, current_user.profile.blockers.ids).where(private: false, isdisabled: false).joins(:user_tags, :user).where(user_tags: {tag_id: @tag.id}, users: {isunderage: current_user.isunderage}).order(:name).paginate(page: params[:page], per_page: 15)
	end

	def new
		@tag = Tag.new
	end

	def create
		tag_params[:name].downcase!

	 	@newtag = false

	 	@tag = Tag.find_or_create_by(tag_params)
		
		UserTag.find_or_create_by(profile_id: current_user.profile.id, tag_id: @tag.id) do |t|
	 		@newtag = true
		end

		respond_to do |format|
	    	if @tag.save
	        	format.js
			else
				format.html {render 'new'}
				format.js
			end
	    end
		
	end

	def destroy
		@profile_tag = UserTag.find_by(profile_id: current_user.profile.id, tag_id: @tag.id)
		
		respond_to do |format|
			if @profile_tag != nil and current_user.profile.id == @profile_tag.profile_id 
				@profile_tag.destroy

				if @tag.profiles.blank?
					@tag.destroy
				end
			end
			format.html { redirect_to request.referer, notice: 'Tag was deleted.' }
	    	format.js
		end
 
	end

	def remove
    
  	end

	private 

	def tag_params
		params.require(:tag).permit(:name)
	end

	def set_tag
		@tag = Tag.find(params[:id])
	end

	def set_user_tags
		@taglist = current_user.profile.tags.map(&:name).join(', ')
	end

	def require_same_user_t
		# @keyword = Keyword.find(params[:id])
		# @p = UserKeyword.find(params[:profile_id => @keyword.id])
		
        if current_user.profile.id != (@profile_tag.user_id || !current_user.admin?)
            redirect_back(fallback_location: root_path)
        end
    end



end