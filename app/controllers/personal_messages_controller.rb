class PersonalMessagesController < ApplicationController
  before_action :check_profile_presence
  before_action :find_conversation!
  before_action :check_age_difference, only: [:new]

  def new
    # redirect_to conversation_path(@conversation) and return if @conversation
    
    if @conversation && @conversation.author == current_user.profile
      redirect_to conversation_path(@conversation) and return if !@conversation.personal_messages.last.author_destroy
      logger.debug "CONVERSATION.author: #{current_user.profile.username}"
    end

    if @conversation && @conversation.receiver == current_user.profile
      redirect_to conversation_path(@conversation) and return if !@conversation.personal_messages.last.receiver_destroy
      logger.debug "CONVERSATION.receiver: #{current_user.profile.username}"
    end
    
    @personal_message = current_user.profile.personal_messages.build

    respond_to do |format|
      format.js 
    end

  end

  def create
    @conversation ||= Conversation.create(author_id: current_user.profile.id,
                                          receiver_id: @receiver.id)
    @personal_message = current_user.profile.personal_messages.build(personal_message_params)
    @personal_message.conversation_id = @conversation.id

    respond_to do |format|
      if @personal_message.save
        @personal_message.conversation.touch

        # reset conversation destroy
        if @personal_message.conversation.author == current_user.profile
          @personal_message.conversation.update(author_destroy: false)
        end

        if @personal_message.conversation.receiver == current_user.profile
          @personal_message.conversation.update(receiver_destroy: false)
        end

        # if receiver is blocking current_user, receiver_destroy == true
        if (@personal_message.conversation.receiver != @personal_message.receiver) && @personal_message.receiver.blocking?(current_user.profile)
          @personal_message.update(read: true, author_destroy: true)
        elsif (@personal_message.conversation.receiver == @personal_message.receiver) && @personal_message.receiver.blocking?(current_user.profile)
          @personal_message.update(read: true, receiver_destroy: true)
        end

        # create notification
        if (@personal_message.receiver != current_user.profile) && (!@personal_message.receiver.blocking?(current_user.profile))
          # create Notification for receiver
          Notification.create(recipient: @personal_message.receiver.user, actor: current_user, action: "messaged", notifiable: @conversation)
        end

        format.html { redirect_to request.referer }
        format.js { flash.now[:notice] = "Your message has been sent." }
      else
        format.js { render status: 400 }
        @conversation.destroy unless !@conversation.personal_messages.empty?
      end
    end

    logger.debug "CONVERSATION empty : #{@conversation.personal_messages.empty?.inspect}"
  
  end

  private

  def personal_message_params
    params.require(:personal_message).permit(:body)
  end

  def find_conversation!
    if params[:receiver_id]
      @receiver = Profile.find_by(id: params[:receiver_id])
      redirect_to(root_path) and return unless @receiver
      @conversation = Conversation.between(current_user.profile.id, @receiver.id)[0]
    else
      @conversation = Conversation.find_by(id: params[:conversation_id])
      redirect_to(root_path) and return unless @conversation && @conversation.participates?(current_user.profile)
    end
  end

  def check_age_difference
    @receiver = Profile.find_by(id: params[:receiver_id])
    redirect_back(fallback_location: root_path) unless @receiver.user.isunderage == current_user.isunderage
  end

end