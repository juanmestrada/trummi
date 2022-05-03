class User < ApplicationRecord
	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address"}
  	validates :password, presence: true
  	validates :dob, presence: true
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
    has_one :profile, dependent: :destroy
	has_many :posts, through: :profile
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

	# has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id'
	# has_many :received_conversations, class_name: 'Conversation', foreign_key: 'received_id'
	# has_many :personal_messages, dependent: :destroy

	has_many :notifications, foreign_key: :recipient_id, dependent: :destroy

	def after_database_authentication
        
        if self.age(self.dob) >= 18 
			self.update_attribute(:isunderage, false)
		end
    end

	def update_age(dob)
		if self.age(dob) >= 18 
			self.update(isunderage: false)
		end
	end

	def age(dob)
	  now = Time.now.utc.to_date
	  now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
	end
end
