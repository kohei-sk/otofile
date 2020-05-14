class UsersController < ApplicationController
  
  def index
  end

  def show
      @user = User.find_by(userid: "#{params[:userid]}")
      if @user.nil?
        redirect_to "/users/nouser", notice: '存在しないアカウントです'
      end
    
  end

  def nouser
  end

end
