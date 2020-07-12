class UsersController < ApplicationController
  before_action :common

  def show
    if !@user_name
      render "/users/nouser"
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

      @posts = Post.where(user_id: @user_name.id).order(created_at: "DESC").page(params[:activity]).without_count.per(3)
      @user_likes = Like.where(l_uid: @user_name.id).order(created_at: "DESC").page(params[:favorite]).without_count.per(3)

      @prf_count = 0
      if @profile.present?
        @prf_count += 1 if @profile.free_area.present?
        @prf_count += 1 if @profile.trendartist.present?
        @prf_count += 1 if @profile.trendsong.present?
        @prf_count += 1 if @profile.fvcate.present?
        @prf_count += 1 if @profile.fvartist.present?
        @prf_count += 1 if @profile.fvsong.present?
        @prf_count += 1 if @profile.fes_sche.present?
        @prf_count += 1 if @profile.fes_his.present?
        @prf_count += 1 if @profile.fvmv.present?
        @prf_count += 1 if @profile.fav_playlist.present?
        @prf_count += 1 if @profile.histories.present?
      end
      @prf_count = @prf_count.to_i * 100 / 11
    end
  end
end
