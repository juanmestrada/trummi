class Conversation < ApplicationRecord
  belongs_to :author, class_name: 'Profile'
  belongs_to :receiver, class_name: 'Profile'

  has_many :personal_messages, -> { order(created_at: :asc) }, dependent: :destroy
  has_one :latest_pm, -> { PersonalMessage.latest_pm_for_conversation }, class_name: "PersonalMessage"

  validates :author, uniqueness: {scope: :receiver}


  # scope :participating, -> (user) do
  #   where("(conversations.author_id = ? OR conversations.receiver_id = ?)", user.id, user.id)
  # end

  scope :last_active_pm, -> (user) do
    joins(:personal_messages)
    where("(personal_messages.conversation.author = ? AND personal_messages.author_destroy = ? OR personal_messages.conversation.receiver = ? AND personal_messages.receiver_destroy = ?)", user, false, user, false)
  end

  scope :participating, -> (user) do
    where("(conversations.author_id = ? OR conversations.receiver_id = ?)", user.id, user.id)
  end

  scope :active_authors, -> {
    joins(:author).merge(Profile.where(isdisabled: false))
  }
  
  scope :active_receivers, -> {
    joins(:receiver).merge(Profile.where(isdisabled: false))
  }

  scope :between, -> (sender_id, receiver_id) do
    where(author_id: sender_id, receiver_id: receiver_id).or(where(author_id: receiver_id, receiver_id: sender_id))
  end

  scope :last_author_pm, -> {
    joins(:personal_messages)
    .group('conversations.id')
    .having('personal_messages.id = (SELECT MAX(personal_messages.id))')
    .where('personal_messages.author_destroy = false')
  }

  # scope :last_receiver_pm, -> {
  #   joins(:personal_messages)
  #   .group('personal_messages.conversation_id')
  #   .where('personal_messages.receiver_destroy = false')
  #   .having('personal_messages.created_at = (SELECT MAX(personal_messages.created_at))')
  # }

  scope :last_receiver_pm, -> {
    joins(:personal_messages)
    .group('conversations.id')
    .where('personal_messages.receiver_destroy = false')
    .having('personal_messages.id = (SELECT MAX(personal_messages.id))')
  }

  scope :auth_or_rec, -> (current_user) do
    where(author_destroy: false) if current_user == author
  end

  def with(current_user)
    author == current_user ? receiver : author
  end

  def participates?(user)
    author == user || receiver == user
  end
  
end 