class UsersController < ApplicationController
  before_action :sign_in_required

  def show
    @user = User.find_by(userid: params[:userid])
    if !@user
      render "/users/nouser"
    else
      @msg = Onemessage.find_by(onemessage_uid: @user.id)
      @profile = Profile.find_by(profile_uid: @user.id)
      @post = Post.where(p_userid: @user.id).order(created_at: "DESC")
      @user_like = Like.where(l_uid: @user.id).order(created_at: "DESC")
      @follow = Follow.find_by(u_id: @user.id, f_id: current_user.id)
    end
  end

  private

  def onemessage_params
    params.require(:onemessage).permit(:message).merge(onemessage_uid: current_user.id)
  end
end
