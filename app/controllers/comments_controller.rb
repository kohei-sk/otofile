class CommentsController < ApplicationController
    before_action :sign_in_required
before_action :cmt_check, except: [:new, :create]

    def cmt_check
        @cmt = Comment.find_by(id: params[:id], c_uid: current_user.id)
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
            redirect_to "/p/#{@cmt.post_id}", notice: '投稿できませんでした'
        end
    end

    def update
        if @cmt.update(comment_update_params)
            redirect_to "/p/#{@cmt.post_id}", notice: '更新しました'
        else
            render "/c/#{@cmt.id}/edit"
        end
    end

    def destroy
        if @cmt.destroy
            redirect_to "/p/#{@cmt.post_id}", notice: '削除しました'
        else
            render "/c/#{@cmt.id}/edit"
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
