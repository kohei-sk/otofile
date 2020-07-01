class WelcomeController < ApplicationController
  def index
    @posts = Post.all.order(created_at: "DESC").page(params[:home_post]).without_count.per(5)
  end
end
