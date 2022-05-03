class PersonalMessage < ApplicationRecord
  belongs_to :conversation
  belongs_to :profile, foreign_key: :profile_id

  validates :body, presence: true, length: { minimum: 1, maximum: 640, too_short: "Too short (minimum is 2 characters)", too_long: "Too long (maximum is 560 characters)" }

  
  # after_create_commit do
  #   conversation.touch
  #   NotificationBroadcastJob.perform_later(self)
  # end

  def receiver
    if conversation.author == conversation.receiver || conversation.receiver == profile
      conversation.author
    else
      conversation.receiver
    end
  end

  def self.latest_pm_for_conversation
    # latest_pm_ids = select("max(id)").group(:conversation_id)
    # where(id: latest_pm_ids)
    group(:conversation_id)
    having('id = (SELECT MAX(id))')
  end


  # def self.latest_author_pm
  #   group(:conversation_id)
  #   having('id = (SELECT MAX(id))')
  #   where(author_destroy: false)
  # end

  # def self.latest_receiver_pm
  #   group(:conversation_id)
  #   having('id = (SELECT MAX(id))')
  #   where(receiver_destroy: false)
  # end
end