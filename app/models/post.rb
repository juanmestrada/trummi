class Post < ApplicationRecord
	validates :content, presence: { message: "Post can't be blank" }, length: { minimum: 2, maximum: 5000, too_short: "Too short (minimum is 2 characters)", too_long: "Too long (maximum is 5000 characters)" }
	
	default_scope -> { order(created_at: :desc) }
	# scope :following, ->(followers) { where user_id: followers }
	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy 
	
	has_many :crying_reactions, dependent: :destroy
	has_many :tea_reactions, dependent: :destroy
	has_many :tellmemore_reactions, dependent: :destroy
	has_many :what_reactions, dependent: :destroy
	has_many :disapproval_reactions, dependent: :destroy
	has_many :excited_reactions, dependent: :destroy
	has_many :entertained_reactions, dependent: :destroy
	has_many :fightme_reactions, dependent: :destroy
	has_many :dafuq_reactions, dependent: :destroy
	has_many :proud_reactions, dependent: :destroy
	has_many :mad_reactions, dependent: :destroy
	has_many :clapping_reactions, dependent: :destroy
	has_many :unsure_reactions, dependent: :destroy
	has_many :laughing_reactions, dependent: :destroy
	has_many :thatsracist_reactions, dependent: :destroy
	has_many :thinkaboutit_reactions, dependent: :destroy
	has_many :wtf_reactions, dependent: :destroy
	has_many :crying2_reactions, dependent: :destroy
	belongs_to :profile
	has_one :user, through: :profile
	mount_uploader :image, ImageUploader

	def thumbs_up_total
	  self.likes.where(like: true).size
	end

	def thumbs_down_total
	  self.likes.where(like: false).size    
	end

	def current_user_like(user)
	  self.likes.where(like: true, user: user).exists?
	end

	def current_user_dislike(user)
	  self.likes.where(like: false, user: user).exists?
	end

	def crying_total
	  self.crying_reactions.where(crying_reaction: true).size
	end

	def tea_total
	  self.tea_reactions.where(tea_reaction: true).size
	end

	def tellmemore_total
	  self.tellmemore_reactions.where(tellmemore_reaction: true).size
	end

	def what_total
	  self.what_reactions.where(what_reaction: true).size
	end

	def disapproval_total
	  self.disapproval_reactions.where(disapproval_reaction: true).size
	end

	def excited_total
		self.excited_reactions.where(excited_reaction: true).size
	end

	def entertained_total
		self.entertained_reactions.where(entertained_reaction: true).size
	end

	def fightme_total
		self.fightme_reactions.where(fightme_reaction: true).size
	end

	def dafuq_total
		self.dafuq_reactions.where(dafuq_reaction: true).size
	end

	def proud_total
		self.proud_reactions.where(proud_reaction: true).size
	end

	def mad_total
		self.mad_reactions.where(mad_reaction: true).size
	end

	def clapping_total
		self.clapping_reactions.where(clapping_reaction: true).size
	end

	def unsure_total
		self.unsure_reactions.where(unsure_reaction: true).size
	end

	def laughing_total
		self.laughing_reactions.where(laughing_reaction: true).size
	end

	def thatsracist_total
		self.thatsracist_reactions.where(thatsracist_reaction: true).size
	end

	def thinkaboutit_total
		self.thinkaboutit_reactions.where(thinkaboutit_reaction: true).size
	end

	def wtf_total
		self.wtf_reactions.where(wtf_reaction: true).size
	end

	def crying2_total
		self.crying2_reactions.where(crying2_reaction: true).size
	end

	def max_reaction
		arr = {"crying" => crying_total, "tea" => tea_total, "tellmemore" => tellmemore_total, "what" => what_total, "disapproval" => disapproval_total, "excited" => excited_total, "entertained" => entertained_total, "fightme" => fightme_total, "dafuq" => dafuq_total, "proud" => proud_total, "mad" => mad_total, "clapping" => clapping_total, "unsure" => unsure_total, "laughing" => laughing_total, "thatsracist" => thatsracist_total, "thinkaboutit" => thinkaboutit_total, "wtf" => wtf_total, "crying2" => crying2_total}
		
		reacimg = ''
		reacsize = ''
		arr.max_by{ |k,v| reacimg = k; reacsize = v }
		# return reacimg, reacsize 
	end
	
end
