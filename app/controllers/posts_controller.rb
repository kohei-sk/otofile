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
      redirect_to "/p/#{@post.id}", notice: '投稿しました'
    else
      render "posts/new"
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to "/p/#{params[:id]}", notice: '更新しました'
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

  def show
    if !@post
      render "posts/nopost"
    end
    @cmt = Comment.new
    @p_cmt = Comment.where(post_id: params[:id]).order(created_at: "DESC")
  end

  private
    def post_params
      params.require(:post).permit(:title, :comment, :img, :remove_img).merge( user_id: current_user.id)
    end
end
