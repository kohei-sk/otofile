class HomeController < ApplicationController
  def index
    new_posts = Post.order(created_at: :desc).limit(1)
    new_posts.each do |new_post|
      gon.ytid = new_post.ytid
    end

    gon.yt_head_img = 'url("https://img.youtube.com/vi/' + gon.ytid + '/maxresdefault.jpg")'

    @posts = Post.order(created_at: :desc).limit(15)
  end
end
