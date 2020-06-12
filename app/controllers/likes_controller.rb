class LikesController < ApplicationController
  before_action :sign_in_required
  before_action :common
  before_action :like_check

  def like_check
    @like = Like.find_by(post_id: params[:id], l_uid: current_user.id)
  end

  def create
    if !@like
      Like.create(post_id: params[:id], l_uid: current_user.id)
    else
      redirect_to "/p/#{params[:id]}/unlike"
    end
  end

  def destroy
    if @like
      @like.destroy
    else
      redirect_to "/p/#{params[:id]}/like"
    end
  end
end
