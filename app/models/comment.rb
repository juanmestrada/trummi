class Comment < ApplicationRecord
	validates :content, presence: true, length: { minimum: 2, maximum: 5000, too_short: "Too short (minimum is 2 characters)", too_long: "Too long (maximum is 5000 characters)" }
	belongs_to :profile
	belongs_to :post
	validates :profile_id, presence: true
	validates :post_id, presence: true
	default_scope -> { order(created_at: :asc) }

end