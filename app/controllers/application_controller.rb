class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    #ユーザー登録のパラメーター追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :userid, :userimg])
    devise_parameter_sanitizer.permit(:account_update, keys: [
                                                         :username,
                                                         :userid,
                                                         :userimg,
                                                         :sns_t,
                                                         :sns_f,
                                                         :sns_i,
                                                         :sns_l,
                                                         :userlink,
                                                       ])
  end

  private

  def sign_in_required
    redirect_to new_user_session_url unless user_signed_in?
  end
end
