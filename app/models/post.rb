class Post < ApplicationRecord
  validates :title, presence: true
  # validates :ytid, presence: true
  # validates :ytid, presence: true, format: { with: /\A[\w@-]*[A-Za-z][\w@-]*\z/ }
end
