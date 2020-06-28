class Comment < ApplicationRecord
  belongs_to :post
  has_many :replies, :dependent => :destroy
  validates :comment, presence: true
end
