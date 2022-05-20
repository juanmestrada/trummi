class Profile < ApplicationRecord
	# validates :username, presence: true, length: { minimum: 3, maximum: 15, too_short: "Too short (minimum is 3 characters)", too_long: "Too long (maximum is 15 characters)"}, uniqueness: { case_sensitive: false }
	validates :name, presence: { message: "Name can't be blank" }, length: { minimum: 2, maximum: 30, too_short: "Name is too short (minimum is 2 characters)", too_long: "Name is too long (maximum is 30 characters)"}
	validates :headline, presence: { message: "Headline can't be blank" }, length: { minimum: 2, maximum: 150, too_short: "Headline is too short (minimum is 2 characters)", too_long: "Headline is too long (maximum is 140 characters)"}
	validates :about, presence: { message: "About can't be blank" }, length: { minimum: 10, maximum: 650, too_short: "About is too short (minimum is 10 characters)", too_long: "About is too long (maximum is 650 characters)"}
	validates :searchingfor, presence: { message: "Searching for can't be blank" }, length: { minimum: 10, maximum: 650, too_short: "Searching for is too short (minimum is 10 characters)", too_long: "Searching for is too long (maximum is 650 characters)"}
	# validates :location, presence: true
	validates :religion, presence: { message: "Religion can't be blank" }, unless: :user_is_child
	validates :education, presence: { message: "Education level can't be blank" }, unless: :user_is_child
	validates :ethnicity, presence: { message: "Ethnicity can't be blank" }, unless: :user_is_child
	validates :relationship, presence: { message: "Relationship status can't be blank" }, unless: :user_is_child
	validates :sexuality, presence: { message: "Sexual orientation can't be blank" }, unless: :user_is_child
	validates :height, presence: { message: "Height can't be blank" }, unless: :user_is_child
	validates :bodytype, presence: { message: "Body type can't be blank" }, unless: :user_is_child
	validates :eyecolor, presence: { message: "Eye color can't be blank" }, unless: :user_is_child
	validates :haircolor, presence: { message: "Hair color can't be blank" }, unless: :user_is_child
	validates :living, presence: { message: "Living situation can't be blank" }, unless: :user_is_child
	validates :kids, presence: { message: "Have kids can't be blank" }, unless: :user_is_child
	validates :smoking, presence: { message: "Smoking can't be blank" }, unless: :user_is_child
	validates :drinking, presence: { message: "Drinking can't be blank" }, unless: :user_is_child
	# validates :language, presence: true
	# validates :verified, presence: true
	# validates :private, presence: true
	

	belongs_to :user, dependent: :destroy
	has_many :posts
	# has_many :profile_keywords
	has_many :user_tags
	# has_many :keywords, through: :profile_keywords
	has_many :tags, through: :user_tags
	has_many :comments, dependent: :destroy
	
	has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
	has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

	has_many :following, through: :active_relationships, source: :followed
	has_many :followers, through: :passive_relationships, source: :follower

	has_many :active_blockings, class_name: "Block", foreign_key: "blocker_id", dependent: :destroy
	has_many :passive_blockings, class_name: "Block", foreign_key: "blockee_id", dependent: :destroy

	has_many :blocking, through: :active_blockings, source: :blockee
	has_many :blockers, through: :passive_blockings, source: :blocker

	has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id'
	has_many :received_conversations, class_name: 'Conversation', foreign_key: 'receiver_id'
	has_many :personal_messages, dependent: :destroy
		

	scope :underage, -> (user) { where(isunderage: user.isunderage) }
	scope :notdisabled, -> { where(isdisabled: false)}

	scope :notblocked, ->(blocking, blockers) {
		where.not(id: blocking).where.not(id: blockers)
	}
	
	mount_uploader :image1, ImageUploader
	mount_uploader :image2, ImageUploader
	mount_uploader :image3, ImageUploader
	mount_uploader :image4, ImageUploader

	# user is an adult
	def user_is_child
		self.user.isunderage
	end

	#follow another user
	def follow(other)
		if !blocking?(other)
			active_relationships.create(followed_id: other.id)
		end
	end

	#unfollow a user
	def unfollow(other)
		active_relationships.find_by(followed_id: other.id).destroy
	end

	#is following
	def following?(other)
		following.include?(other)
	end

	def block(other)
		active_blockings.create(blockee_id: other.id)
	end

	def unblock(other)
		active_blockings.find_by(blockee_id: other.id).destroy
	end

	def blocking?(other)
		blocking.include?(other)
	end

	def self.ransackable_attributes(auth_object = nil)
		["name", "username", "religion", "education", "ethnicity", "relationship", "sexuality", "height", "weight", "bodytype", "eyecolor", "haircolor", "living", "kids", "smoking", "drinking", "language", "verified", "private", "isunderage", "isdisabled", 'blockee_id', 'age']
	end

end
