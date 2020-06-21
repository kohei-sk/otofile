class CommentsController < ApplicationController
    before_action :sign_in_required
    before_action :cmt_check, only: [:update, :edit, :destroy]

    def cmt_check
        @cmt = Comment.find(params[:id])
        @user = User.find(current_user.id)
    end

    def new
        @cmt = Comment.new
    end

    def create
        @cmt = Comment.new(comment_create_params)
        @user = User.find(current_user.id)
        @count = Comment.where(post_id: params[:id])

        if !@cmt.save
            respond_to do |format|
                format.html
                format.json
            end
            render "/p/#{@cmt.post_id}", notice: '投稿できませんでした'
        end
    end

    def update
        if @cmt.update(comment_update_params)
            respond_to do |format|
                format.html
                format.json
            end
        else
            render "/p/#{@cmt.post_id}", notice: '更新できませんでした'
        end
    end

    def destroy
        cmt = Comment.find(params[:id])
        post = Post.find(cmt.post_id)
        if @cmt.destroy
            @count = Comment.where(post_id: post.id).count
            respond_to do |format|
                format.html
                format.json
            end
        else
            render "/p/#{@cmt.post_id}", notice: '削除できませんでした'
        end
    end

    private
        def comment_create_params
         params.require(:comment).permit(:comment).merge(post_id: params[:id], c_uid: current_user.id)
        end
        def comment_update_params
            params.permit(:comment)
        end

end
