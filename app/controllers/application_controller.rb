class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_request_variant

  def common
    @user_name = User.find_by(userid: params[:userid])
    if @user_name
      gon.userid = @user_name.userid
    end
  end

  def rank_posts
    from = Time.current.ago(7.days)
    to = Time.current
    posts = Post.left_joins(:likes)
    @rank_posts = posts.group("posts.id").select("posts.*", "count(likes.id) AS likes").where(created_at: from..to).order("likes desc").order(created_at: "DESC").limit(10)

    render partial: "layouts/aside"
  end

  if Rails.env.production?
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
  end

  def routing_error
    raise ActionController::RoutingError, params[:path]
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :userid])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :userid, :userimg, :remove_userimg, :hdrimg, :remove_hdrimg, :sns_t, :sns_f, :sns_i, :sns_l, :userlink])
  end

  private

  def sign_in_required
    redirect_to new_user_session_url unless user_signed_in?
  end

  def set_request_variant
    request.variant = request.device_variant
  end

  def render_404
    render "error/404", status: :not_found
  end
end
