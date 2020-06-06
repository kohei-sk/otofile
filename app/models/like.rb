class Like < ApplicationRecord
  validates_uniqueness_of :l_pid, scope: :l_uid
end
