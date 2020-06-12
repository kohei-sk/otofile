class Like < ApplicationRecord
  belongs_to :post
  validates_uniqueness_of :post_id, scope: :l_uid
end
