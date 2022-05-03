class Tag < ApplicationRecord
	validates :name, presence: { message: "Tag name can't be blank" }, length: { minimum: 2, maximum: 50, too_short: "Too short (minimum is 2 characters)", too_long: "Too long (maximum is 50 characters)" }
	has_many :user_tags, dependent: :destroy
	has_many :profiles, through: :user_tags
	before_save :downcase_fields

	def self.search_by_tags(name)
		tags_array = name.split(' ')
		if tags_array.size == 1
			where('name LIKE ?',
				"%#{tags_array[0]}%").order(:name)
		else
			where('name LIKE ? or name LIKE ?',
				"%#{tags_array[0]}%", "%#{tags_array[1]}%").order(:name)
		end
	end

	def tag_total(name)
	  self.profile_tags.where(tag: name).size
	end

	def downcase_fields
	  self.name = self.name.downcase
	end

	def check_params   
	   self.name.downcase     
	end
end