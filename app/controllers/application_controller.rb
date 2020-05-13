class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    #ユーザー登録のパラメーター追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:userid])
    devise_parameter_sanitizer.permit(:account_update, keys: [:userid])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:userimg])
    devise_parameter_sanitizer.permit(:account_update, keys: [:userimg])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:profile])
    devise_parameter_sanitizer.permit(:account_update, keys: [:profile])
  end

  private

  def sign_in_required
    redirect_to new_user_session_url unless user_signed_in?
  end
end
