class Post < ApplicationRecord
  has_many :likes, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  belongs_to :user
  validates :title, presence: true
  mount_uploader :img, PostImgUploader

  validates :title, length: { maximum: 60 }
  validates :comment, length: { maximum: 300 }
end
