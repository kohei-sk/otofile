class WelcomeController < ApplicationController
  def index
    test = []
    @post = Post.where(user_id: 1).page(params[:page]).per(3)
  end
end
