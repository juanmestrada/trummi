class PostsController < ApplicationController
  before_action :check_profile_presence
  before_action :check_isdisabled
  before_action :set_post, only: [:show, :update, :remove, :destroy, :like, :crying_reaction, :tea_reaction, :tellmemore_reaction, :what_reaction, :disapproval_reaction, :excited_reaction, :entertained_reaction, :fightme_reaction, :dafuq_reaction, :proud_reaction, :mad_reaction, :clapping_reaction, :unsure_reaction, :laughing_reaction, :thatsracist_reaction, :thinkaboutit_reaction, :wtf_reaction, :crying2_reaction]
  before_action :check_age_difference, only: [:show]
  before_action :require_same_user, only: [:destroy]
  before_action :require_user_like, only: [:like]
  skip_before_action :verify_authenticity_token, except: [:update, :destroy]

  def index
    @posts = Post.joins(:profile).merge(Profile.notdisabled).where(profile_id: current_user.profile.following.ids).or(Post.joins(:profile).where(profile_id: current_user.profile.id)).paginate(page: params[:page], per_page: 15)

  end

  def show
    # # .includes(:profile, :crying_reactions, :tea_reactions, :tellmemore_reactions, :what_reactions, :disapproval_reactions, :excited_reactions, :entertained_reactions, :fightme_reactions, :dafuq_reactions, :proud_reactions, :mad_reactions, :clapping_reactions, :unsure_reactions, :laughing_reactions, :thatsracist_reactions, :thinkaboutit_reactions, :wtf_reactions, :crying2_reactions)
    @comments = @post.comments.joins(:profile).merge(Profile.notdisabled.notblocked(current_user.profile.blocking.ids, current_user.profile.blockers.ids)).paginate(page: params[:page], per_page: 10)
    
    @commenters = @post.comments.select(:profile_id).where(profile_id: current_user.profile.following.ids).order(:created_at).distinct

    if @post.user == current_user
      Notification.where({recipient: current_user, notifiable_id: @post.id , notifiable_type: "Post"}).destroy_all
    end

  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.profile.posts.new(post_params)
  
    respond_to do |format|
      if @post.save
        format.html
        format.js { flash.now[:notice] = "Your post has been sent." }
      else
        format.js { render status: 400 }
      end
    end
  end

  def update
    
  end

  def remove
    
  end

  def destroy
    @post.destroy
    Notification.where({recipient: current_user, notifiable_id: @post.id, notifiable_type: "Post"}).destroy_all

    respond_to do |format|
      if params[:view] == "show"
        format.html { redirect_to posts_path, status: :ok }
      else
        format.js { render status: :ok }
      end 
    end
    
  end

  def like
    @userlike = Like.find_or_initialize_by(user: current_user, post: @post)
    @userlike.like = params[:like]
    
    if @userlike.save
      
      if @post.user != current_user
        Notification.create(recipient: @post.user, actor: current_user, action: "liked/disliked", notifiable: @post)
      end
      
    end
  
  end
 
  def crying_reaction
    crying = CryingReaction.create(crying_reaction: params[:crying_reaction], user: current_user, post: @post)
        
    if crying.valid?
      if @post.user != current_user
        Notification.create(recipient: @post.user, actor: current_user, action: "reacted to ", notifiable: @post)
      end
      render :reaction
    end
    
  end

  def tea_reaction
    tea = TeaReaction.create(tea_reaction: params[:tea_reaction], user: current_user, post: @post)

    if tea.valid?
      if @post.user != current_user
        Notification.create(recipient: @post.user, actor: current_user, action: "reacted to ", notifiable: @post)
      end
      render :reaction
    end

  end

  def tellmemore_reaction
    tellmemore = TellmemoreReaction.create(tellmemore_reaction: params[:tellmemore_reaction], user: current_user, post: @post)
    
    if tellmemore.valid?
      if @post.user != current_user
        Notification.create(recipient: @post.user, actor: current_user, action: "reacted to ", notifiable: @post)
      end
      render :reaction
    end
    
  end

  def what_reaction
    what = WhatReaction.create(what_reaction: params[:what_reaction], user: current_user, post: @post)

    if what.valid?
      if @post.user != current_user
        Notification.create(recipient: @post.user, actor: current_user, action: "reacted to ", notifiable: @post)
      end
      render :reaction
    end

  end

  def disapproval_reaction
    disapproval = DisapprovalReaction.create(disapproval_reaction: params[:disapproval_reaction], user: current_user, post: @post)

    if disapproval.valid?
      if @post.user != current_user
        Notification.create(recipient: @post.user, actor: current_user, action: "reacted to ", notifiable: @post)
      end
      render :reaction
    end
    
  end

  def excited_reaction
    excited = ExcitedReaction.create(excited_reaction: params[:excited_reaction], user: current_user, post: @post)

    if excited.valid?
      if @post.user != current_user
        Notification.create(recipient: @post.user, actor: current_user, action: "reacted to ", notifiable: @post)
      end
      render :reaction
    end
    
  end

  def entertained_reaction
    entertained = EntertainedReaction.create(entertained_reaction: params[:entertained_reaction], user: current_user, post: @post)

    if entertained.valid?
      if @post.user != current_user
        Notification.create(recipient: @post.user, actor: current_user, action: "reacted to ", notifiable: @post)
      end
      render :reaction
    end
    
  end

  def fightme_reaction
    fightme = FightmeReaction.create(fightme_reaction: params[:fightme_reaction], user: current_user, post: @post)

    if fightme.valid?
      if @post.user != current_user
        Notification.create(recipient: @post.user, actor: current_user, action: "reacted to ", notifiable: @post)
      end
      render :reaction
    end
    
  end

  def dafuq_reaction
    dafuq = DafuqReaction.create(dafuq_reaction: params[:dafuq_reaction], user: current_user, post: @post)

    if dafuq.valid?
      if @post.user != current_user
        Notification.create(recipient: @post.user, actor: current_user, action: "reacted to ", notifiable: @post)
      end
      render :reaction
    end
    
  end

  def proud_reaction
    proud = ProudReaction.create(proud_reaction: params[:proud_reaction], user: current_user, post: @post)

    if proud.valid?
      if @post.user != current_user
        Notification.create(recipient: @post.user, actor: current_user, action: "reacted to ", notifiable: @post)
      end
      render :reaction
    end
    
  end

  def mad_reaction
    mad = MadReaction.create(mad_reaction: params[:mad_reaction], user: current_user, post: @post)

    if mad.valid?
      if @post.user != current_user
        Notification.create(recipient: @post.user, actor: current_user, action: "reacted to ", notifiable: @post)
      end
      render :reaction
    end
    
  end

  def clapping_reaction
    clapping = ClappingReaction.create(clapping_reaction: params[:clapping_reaction], user: current_user, post: @post)
 
    if clapping.valid?
      if @post.user != current_user
        Notification.create(recipient: @post.user, actor: current_user, action: "reacted to ", notifiable: @post)
      end
      render :reaction
    end
    
  end

  def unsure_reaction
    unsure = UnsureReaction.create(unsure_reaction: params[:unsure_reaction], user: current_user, post: @post)

    if unsure.valid?
      if @post.user != current_user
        Notification.create(recipient: @post.user, actor: current_user, action: "reacted to ", notifiable: @post)
      end
      render :reaction
    end
    
  end

  def laughing_reaction
    laughing = LaughingReaction.create(laughing_reaction: params[:laughing_reaction], user: current_user, post: @post)

    if laughing.valid?
      if @post.user != current_user
        Notification.create(recipient: @post.user, actor: current_user, action: "reacted to ", notifiable: @post)
      end
      render :reaction
    end
    
  end

  def thatsracist_reaction
    thatsracist = ThatsracistReaction.create(thatsracist_reaction: params[:thatsracist_reaction], user: current_user, post: @post)

    if thatsracist.valid?
      if @post.user != current_user
        Notification.create(recipient: @post.user, actor: current_user, action: "reacted to ", notifiable: @post)
      end
      render :reaction
    end
    
  end

  def thinkaboutit_reaction
    thinkaboutit = ThinkaboutitReaction.create(thinkaboutit_reaction: params[:thinkaboutit_reaction], user: current_user, post: @post)

    if thinkaboutit.valid?
      if @post.user != current_user
        Notification.create(recipient: @post.user, actor: current_user, action: "reacted to ", notifiable: @post)
      end
      render :reaction
    end
    
  end

  def wtf_reaction
    wtf = WtfReaction.create(wtf_reaction: params[:wtf_reaction], user: current_user, post: @post)

    if wtf.valid?
      if @post.user != current_user
        Notification.create(recipient: @post.user, actor: current_user, action: "reacted to ", notifiable: @post)
      end
      render :reaction
    end
    
  end

  def crying2_reaction
    crying2 = Crying2Reaction.create(crying2_reaction: params[:crying2_reaction], user: current_user, post: @post)
    
    if crying2.valid?
      if @post.user != current_user
        Notification.create(recipient: @post.user, actor: current_user, action: "reacted to ", notifiable: @post)
      end
      render :reaction
    end
    
  end

  private

    def like_params
      params.require(:like).permit(:like)
    end
    
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :image)
    end
    #checks if current user is the creator of post
    def require_same_user
        if current_user.profile != @post.profile and !current_user.admin?
            redirect_back(fallback_location: root_path)
        end
    end

    def check_age_difference
      redirect_back(fallback_location: root_path) unless @post.user.isunderage == current_user.isunderage
    end

    def require_user_like
      if !user_signed_in?
        flash[:alert] = "You must be logged in to perform that action."
        redirect_back(fallback_location: root_path)
      end
    end
end
