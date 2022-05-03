class ProudReaction < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  validates_uniqueness_of :user, scope: :post
end