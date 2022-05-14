class PersonalMessage < ApplicationRecord
  belongs_to :conversation
  belongs_to :profile, foreign_key: :profile_id

  validates :body, presence: true, length: { minimum: 1, maximum: 640, too_short: "Too short (minimum is 2 characters)", too_long: "Too long (maximum is 560 characters)" }

  scope :most_recent, -> { joins(
    "INNER JOIN (
      SELECT DISTINCT ON (conversation_id) conversation_id,id FROM personal_messages ORDER BY conversation_id,updated_at DESC,id
    ) most_recent ON (most_recent.id=personal_messages.id)"
  )}
  
  def receiver
    if conversation.author == conversation.receiver || conversation.receiver == profile
      conversation.author
    else
      conversation.receiver
    end
  end

  def self.latest_pm_for_conversation
    latest_pm_ids = select("max(id)").group(:conversation_id)
    where(id: latest_pm_ids)
  end

end