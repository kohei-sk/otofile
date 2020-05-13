class PostsController < ApplicationController
  def show
    @post = Post.find_by(id: params[:id])
    @userid = @post.p_userid.to_i
    @user = User.find(@userid)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path, notice: '投稿しました'
    else
      render "posts/new"
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      redirect_to "/p/#{params[:id]}", notice: '更新しました'
    else
      render "posts/edit"
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post.destroy
      redirect_to root_path, notice: '削除しました'
    else
      render "/p/#{params[:id]}"
    end
  end


  private
    def post_params
      params.require(:post).permit(:title, :artist, :song, :ytid, :comment).merge(p_userid: current_user.id)
    end
end
