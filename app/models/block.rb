class Block < ApplicationRecord
	belongs_to :blocker, class_name: "Profile"
	belongs_to :blockee, class_name: "Profile"

	validates :blocker_id, presence: true
	validates :blockee_id, presence: true
end
