class UsersController < ApplicationController

  def index
  end

  def show
    user = User.find_by(userid: "#{params[:userid]}")
    if user.nil?
      redirect_to root_path, notice: '存在しないアカウントです'
    else
      @user = user
    end
  end

end
