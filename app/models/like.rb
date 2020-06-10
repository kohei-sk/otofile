class Like < ApplicationRecord
  belongs_to :post
  validates_uniqueness_of :l_pid, scope: :l_uid
end
