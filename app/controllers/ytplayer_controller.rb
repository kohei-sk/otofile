class YtplayerController < ApplicationController
  before_action :sign_in_required

  def index
  end

  def ytlist
    @f_users = Follow.where(user_id: current_user.id).map { |user| user.f_id.to_i }
    @posts = Post.where(user_id: @f_users).where.not(ytid: [nil, ""]).order(created_at: "DESC").limit(30)

    respond_to do |format|
      format.html
      format.json
    end
  end

  def ytpost
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)

    respond_to do |format|
      format.html
      format.json
    end
  end
end
