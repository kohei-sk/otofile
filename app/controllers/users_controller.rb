class UsersController < ApplicationController
  
  def index
  end

  def show
      @user = User.find_by(userid: params[:userid])
      if @user.nil?
        redirect_to "/users/nouser", notice: '存在しないアカウントです'
      end

      @msg = Onemessage.find_by(onemessage_uid: @user.id)
      @profile = Profile.find_by(profile_uid: @user.id)
  end

  def nouser
  end

  private
    def onemessage_params
      params.require(:onemessage).permit(:message).merge(onemessage_uid: current_user.id)
    end

end
