class FollowsController < ApplicationController
  before_action :sign_in_required
  before_action :common
  before_action :follow_check

  def follow_check
    @following = Follow.find_by(f_id: @user_name.id, user_id: current_user.id)
  end

  def create
    if !@following
      Follow.create(f_id: @user_name.id, user_id: current_user.id)
    else
      redirect_to "/#{params[:userid]}/unfollow"
    end
  end

  def destroy
    if @following
      @following.destroy
    else
      redirect_to "/#{params[:userid]}/follow"
    end
  end
end
