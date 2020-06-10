class UsersController < ApplicationController
  before_action :sign_in_required

  def show
    @user = User.find_by(userid: params[:userid])
    if !@user
      render "/users/nouser"
    else
      @msg = Onemessage.find_by(onemessage_uid: @user.id)

      @profile = Profile.find_by(profile_uid: @user.id)

      if @profile
        arr_histories = []
        @profile.histories.each do |history|
          arr_histories.push(history)
        end
        @histories = arr_histories.sort_by! { |a| a[:year] }.reverse!
      end

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
