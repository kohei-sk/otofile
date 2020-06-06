class LikesController < ApplicationController
  before_action :sign_in_required

  def create
    like = Like.find_by(l_pid: params[:id], l_uid: current_user.id)
    if !like
      Like.create(l_pid: params[:id], l_uid: current_user.id)
    else
      redirect_to "/p/#{params[:id]}/unlike"
    end
  end

  def destroy
    like = Like.find_by(l_pid: params[:id], l_uid: current_user.id)
    if like
      like.destroy
    else
      redirect_to "/p/#{params[:id]}/like"
    end
  end
end
