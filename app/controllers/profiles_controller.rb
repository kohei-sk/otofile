class ProfilesController < ApplicationController
  before_action :sign_in_required
  before_action :profile_check

  def profile_check
    @profile = Profile.find_by(user_id: current_user.id)
  end

  def new
    if @profile
      redirect_to "/pr/edit"
    else
      @profile = Profile.new
      @history = @profile.histories.build
    end
  end
  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to "/#{current_user.userid}", notice: '更新しました'
    else
      render "profiles/new"
    end
  end

  def edit
    if !@profile
      redirect_to "/pr/new"
    end
  end

  def update
    if @profile.update(profile_params_up)
      redirect_to "/#{current_user.userid}", notice: '更新しました'
    else
      render "profiles/edit"
    end
  end

  private
    def profile_params
      params.require(:profile).permit(:trendartist, :trendsong, :fvcate, :fvartist, :fvsong, :fvmv, :free_area, :fes_sche, :fes_his, :fav_playlist,
        histories_attributes: [:year, :event])
        .merge(user_id: current_user.id)
    end
    def profile_params_up
      params.require(:profile).permit(:trendartist, :trendsong, :fvcate, :fvartist, :fvsong, :fvmv, :free_area, :fes_sche, :fes_his, :fav_playlist,
        histories_attributes: [:year, :event, :_destroy, :id])
        .merge(user_id: current_user.id)
    end

end
