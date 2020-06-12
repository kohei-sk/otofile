class PostsController < ApplicationController
  before_action :sign_in_required
  before_action :post_check

  def post_check
    @post = Post.find_by(id: params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to "/#{current_user.userid}", notice: '投稿しました'
    else
      render "posts/new"
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to "/#{current_user.userid}", notice: '更新しました'
    else
      render "posts/edit"
    end
  end

  def destroy
    if @post.destroy
      redirect_to "/#{current_user.userid}", notice: '削除しました'
    else
      render "/p/#{params[:id]}/edit"
    end
  end


  private
    def post_params
      params.require(:post).permit(:title, :comment, :img).merge( user_id: current_user.id)
    end
end
