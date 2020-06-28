class Reply < ApplicationRecord
  belongs_to :comment
  validates :reply, presence: true
end
