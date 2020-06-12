class Post < ApplicationRecord
  has_many :likes, :dependent => :destroy
  belongs_to :user
  validates :title, presence: true
  # validates :ytid, presence: true
  # validates :ytid, presence: true, format: { with: /\A[\w@-]*[A-Za-z][\w@-]*\z/ }
  mount_uploader :img, PostImgUploader
end
