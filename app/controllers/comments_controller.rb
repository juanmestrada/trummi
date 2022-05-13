class CommentsController < ApplicationController
	before_action :set_post, only: [ :new, :remove, :destroy ]
	
	def new
	    @comment = Comment.new
	end

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(comment_params)
		@comment.profile = current_user.profile
		@commenters = @post.comments.where(profile_id: current_user.profile.following.ids).order(:created_at).distinct

		respond_to do |format|
	      if @comment.save  
	      	if @post.profile != current_user.profile
				Notification.create(recipient: @post.user, actor: current_user, action: "commented on", notifiable: @post)
			end
			 format.js { flash.now[:notice] = "Your comment has been posted." }
	      else
	      	format.html { flash.now[:alert] = "There was an error." }
	        format.js  { render status: 400 }
	      end
	    end
	end

	def remove
		@comment = @post.comments.find(params[:id])
	end

	def destroy
		@comment = @post.comments.find(params[:id])
		@commenters = @post.comments.where(profile_id: current_user.profile.following.ids).distinct
		@comment.destroy

		respond_to do |format|
		 format.js { render status: :ok }
		end
	end


	private

	def comment_params
		params.require(:comment).permit(:content)
	end

	def set_post
      @post = Post.find(params[:post_id])
    end

end