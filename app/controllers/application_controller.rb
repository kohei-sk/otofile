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

    devise_parameter_sanitizer.permit(:account_update, keys: [:message])
    devise_parameter_sanitizer.permit(:account_update, keys: [:sns_t])
    devise_parameter_sanitizer.permit(:account_update, keys: [:sns_f])
    devise_parameter_sanitizer.permit(:account_update, keys: [:sns_i])
    devise_parameter_sanitizer.permit(:account_update, keys: [:sns_l])
    devise_parameter_sanitizer.permit(:account_update, keys: [:userlink])
    devise_parameter_sanitizer.permit(:account_update, keys: [:trendartist])
    devise_parameter_sanitizer.permit(:account_update, keys: [:torendsong])
    devise_parameter_sanitizer.permit(:account_update, keys: [:fvcate])
    devise_parameter_sanitizer.permit(:account_update, keys: [:fvartist])
    devise_parameter_sanitizer.permit(:account_update, keys: [:fvsong])
    devise_parameter_sanitizer.permit(:account_update, keys: [:fvmv])
    devise_parameter_sanitizer.permit(:account_update, keys: [:mmyband])
    devise_parameter_sanitizer.permit(:account_update, keys: [:h_year1])
    devise_parameter_sanitizer.permit(:account_update, keys: [:h_year2])
    devise_parameter_sanitizer.permit(:account_update, keys: [:h_year3])
    devise_parameter_sanitizer.permit(:account_update, keys: [:h_year4])
    devise_parameter_sanitizer.permit(:account_update, keys: [:h_year5])
    devise_parameter_sanitizer.permit(:account_update, keys: [:h_content1])
    devise_parameter_sanitizer.permit(:account_update, keys: [:h_content2])
    devise_parameter_sanitizer.permit(:account_update, keys: [:h_content3])
    devise_parameter_sanitizer.permit(:account_update, keys: [:h_content4])
    devise_parameter_sanitizer.permit(:account_update, keys: [:h_content5])
  end

  private

  def sign_in_required
    redirect_to new_user_session_url unless user_signed_in?
  end
end
