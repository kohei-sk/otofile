class ProfilesController < ApplicationController
  before_action :sign_in_required

  def new
    profile = Profile.find_by(profile_uid: current_user.id)
    if profile
      redirect_to "/pr/edit"
    else
      @profile = Profile.new
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
    if @profile.update(profile_params)
      redirect_to root_path, notice: '更新しました'
    else
      render "profiles/edit"
    end
  end

  private
    def profile_params
      params.require(:profile).permit(:sns_t, :sns_f, :sns_i, :sns_l, :userlink, :trendartist, :torendsong, :fvcate, :fvartist, :fvsong, :fvmv, :myband, :h_year1, :h_year2, :h_year3, :h_year4, :h_year5, :h_content1, :h_content2, :h_content3, :h_content4, :h_content5).merge(profile_uid: current_user.id)
    end

end
