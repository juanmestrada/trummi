class ProfileTag < ApplicationRecord
	belongs_to :tag
	belongs_to :profile

end