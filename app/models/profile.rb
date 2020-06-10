class Profile < ApplicationRecord
  belongs_to :user
  has_many :histories, :dependent => :destroy
  accepts_nested_attributes_for :histories, allow_destroy: true
end
