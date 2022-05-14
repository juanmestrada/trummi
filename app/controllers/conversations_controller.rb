class ConversationsController < ApplicationController
  before_action :check_profile_presence
  before_action :check_isdisabled
  before_action :set_conversation, except: [:index]
  before_action :check_participating!, except: [:index]
  # before_action :authenticate_user! 

  def index
    
    # @conversations = current_user.profile.authored_conversations.last_author_pm.group("conversations.id").order("personal_messages.created_at DESC").paginate(page: params[:page], per_page: 15).or(current_user.profile.received_conversations.last_receiver_pm.group("conversations.id").order("personal_messages.created_at DESC").paginate(page: params[:page], per_page: 15))
    
    @conversations = current_user.profile.authored_conversations.includes(:latest_pm).where(personal_messages: { author_destroy: false }).order("personal_messages.created_at DESC").paginate(page: params[:page], per_page: 15).or(current_user.profile.received_conversations.includes(:latest_pm).where(personal_messages: { receiver_destroy: false }).order("personal_messages.created_at DESC").paginate(page: params[:page], per_page: 15))
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    
    if @conversation.author == current_user.profile
      @convmsg = @conversation.personal_messages.where(author_destroy: false )
      @convparticipant = @conversation.receiver
      Notification.where({recipient: current_user, actor: @conversation.receiver.user, notifiable_type: "Conversation"}).destroy_all
    end

    if @conversation.receiver == current_user.profile
      @convmsg = @conversation.personal_messages.where(receiver_destroy: false )
      @convparticipant = @conversation.author
      Notification.where({recipient: current_user, actor: @conversation.author.user, notifiable_type: "Conversation"}).destroy_all
    end
    
    if @conversation.personal_messages.last.receiver.id == current_user.profile.id
      @conversation.personal_messages.last.update(read: true)
    end

    @personal_message = PersonalMessage.new

  end

  def remove
    
  end

  def destroy

    if @conversation.author == current_user.profile
      #update coversation author_destroy
      @conversation.update(author_destroy: true)
      @conversation.personal_messages.update(author_destroy: true)
      
      # destroy message notifications
      Notification.where({recipient: current_user, actor: @conversation.receiver.user, notifiable_type: "Conversation"}).destroy_all
    end

    if @conversation.receiver == current_user.profile
      #update coversation receiver_destroy
      @conversation.update(receiver_destroy: true)
      @conversation.personal_messages.update(receiver_destroy: true)
    
      # destroy message notifications
      Notification.where({recipient: current_user, actor: @conversation.author.user, notifiable_type: "Conversation"}).destroy_all
    end

    if @conversation.author_destroy && @conversation.receiver_destroy
      @conversation.destroy
      
      respond_to do |format|
        format.js { render status: :ok }
      end
    end

  end

  private

  def set_conversation
    @conversation = Conversation.find_by(id: params[:id])
  end

  def check_participating!
    redirect_to root_path unless @conversation && @conversation.participates?(current_user.profile)
  end
end