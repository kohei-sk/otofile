class ProfilesController < ApplicationController
  before_action :sign_in_required

  def new
    profile = Profile.find_by(profile_uid: current_user.id)
    if profile
      redirect_to "/pr/edit"
    else
      @profile = Profile.new
      @history = @profile.histories.build
    end
  end
  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to root_path, notice: '更新しました'
    else
      render "profiles/new"
    end
  end

  def edit
    @profile = Profile.find_by(profile_uid: current_user.id)
    if !@profile
      redirect_to "/pr/new"
    end
  end

  def update
    @profile = Profile.find_by(profile_uid: current_user.id)
    if @profile.update(profile_params_up)
      redirect_to root_path, notice: '更新しました'
    else
      render "profiles/edit"
    end
  end

  private
    def profile_params
      params.require(:profile).permit(:trendartist, :trendsong, :fvcate, :fvartist, :fvsong, :fvmv, :free_area, :fes_sche, :fes_his, :fav_playlist, :h_content4, :h_content5, histories_attributes: [:year, :event]).merge(profile_uid: current_user.id)
    end
    def profile_params_up
      params.require(:profile).permit(:trendartist, :trendsong, :fvcate, :fvartist, :fvsong, :fvmv, :free_area, :fes_sche, :fes_his, :fav_playlist, :h_content4, :h_content5, histories_attributes: [:year, :event, :_destroy, :id]).merge(profile_uid: current_user.id)
    end

end
