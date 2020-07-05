class Profile < ApplicationRecord
  belongs_to :user
  has_many :histories, :dependent => :destroy
  accepts_nested_attributes_for :histories, allow_destroy: true

  validates :free_area, length: { maximum: 300 }
  validates :trendartist, length: { maximum: 300 }
  validates :trendsong, length: { maximum: 300 }
  validates :fvcate, length: { maximum: 50 }
  validates :fvartist, length: { maximum: 300 }
  validates :fvsong, length: { maximum: 300 }
  validates :fes_sche, length: { maximum: 300 }
  validates :fes_his, length: { maximum: 300 }
  #validates :fvmv
  validates :fav_playlist, length: { maximum: 300 }
end
