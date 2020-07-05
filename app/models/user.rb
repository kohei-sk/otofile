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

  validates :username, length: { maximum: 50 }
  validates :userid, presence: true, uniqueness: true, length: { maximum: 20 }
  validate :password_complexity #6..20
  validate :userid_complexity

  def password_complexity
    return if password.blank? || password =~ /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])/

    errors.add :password, "には半角アルファベット（大文字・小文字）、半角数字を１つ以上入れてください"
  end

  def userid_complexity
    return if userid =~ /(?=.*?[\A[a-zA-Z0-9]+\z])/

    errors.add :userid, "は半角アルファベット（大文字・小文字）、半角数字で入力してください"
  end

  # def update_without_current_password(params, *options)
  #   if params[:password].blank? && params[:password_confirmation].blank?
  #     params.delete(:password)
  #     params.delete(:password_confirmation)
  #     params.delete(:current_password)

  #     result = update_attributes(params, *options)
  #     clean_up_passwords
  #     result
  #   end
  # end

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
