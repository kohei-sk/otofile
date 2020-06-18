class User < ApplicationRecord
  has_many :profiles, :dependent => :destroy
  has_many :onemessages, :dependent => :destroy
  has_many :follows, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :omniauthable,
         omniauth_providers: [:twitter]

  #validates :username, presence: true
  validates :userid, presence: true, uniqueness: true, format: { with: /\A[a-z\d]{1,30}+\z/i }

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["info"]["nickname"]
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
      end
    else
      super
    end
  end

  mount_uploader :userimg, UserImageUploader
  mount_uploader :hdrimg, UserHdrimgUploader
end
