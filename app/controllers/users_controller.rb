class UsersController < ApplicationController
  before_action :common

  def show
    if !@user_name
      if user_signed_in?
        render "/users/nouser"
      else
        redirect_to "/welcome/"
      end
    else
      @msg = Onemessage.find_by(user_id: @user_name.id)

      @profile = Profile.find_by(user_id: @user_name.id)
      if @profile
        arr_histories = []
        @profile.histories.each do |history|
          arr_histories.push(history)
        end
        @histories = arr_histories.sort_by! { |a| a[:year] }.reverse!
      end

      @posts = Post.where(user_id: @user_name.id).order(created_at: "DESC").page(params[:activity]).without_count.per(5)
      @user_likes = Like.where(l_uid: @user_name.id).order(created_at: "DESC").page(params[:favorite]).without_count.per(5)
    end
  end
end
