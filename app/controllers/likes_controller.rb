class LikesController < ApplicationController
  before_action :sign_in_required
  before_action :common
  before_action :like_check

  def like_check
    @like = Like.find_by(post_id: params[:id], l_uid: current_user.id)
  end

  def create
    @msg = Onemessage.find_by(user_id: current_user.id)
    if !@like
      Like.create(post_id: params[:id], l_uid: current_user.id)
      @count = Like.where(post_id: params[:id]).count
      respond_to do |format|
        format.html
        format.json
      end
    else
      redirect_to "/p/#{params[:id]}/unlike"
    end
  end

  def destroy
    if @like
      @like.destroy
      @count = Like.where(post_id: params[:id]).count
      respond_to do |format|
        format.html
        format.json
      end
    else
      redirect_to "/p/#{params[:id]}/like"
    end
  end
end
