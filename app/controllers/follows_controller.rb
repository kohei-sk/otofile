class FollowsController < ApplicationController
  before_action :sign_in_required

  def create
    user = User.find_by(userid: params[:userid])
    follow = Follow.find_by(u_id: user.id, f_id: current_user.id)
    if !follow
      Follow.create(u_id: user.id, f_id: current_user.id, user_id: current_user.id)
    else
      redirect_to "/#{params[:userid]}/unfollow"
    end
  end

  def destroy
    user = User.find_by(userid: params[:userid])
    follow = Follow.find_by(u_id: user.id, f_id: current_user.id)
    if follow
      follow.destroy
    else
      redirect_to "/#{params[:userid]}/follow"
    end
  end
end
