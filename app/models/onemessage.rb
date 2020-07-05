class Onemessage < ApplicationRecord
  belongs_to :user

  validates :message, length: { maximum: 100 }
end
