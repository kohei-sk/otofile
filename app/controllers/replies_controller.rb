class RepliesController < ApplicationController
    before_action :sign_in_required
    before_action :reply_check, only: [:update, :destroy]

    def reply_check
        @reply = Reply.find(params[:id])
        @cmt = Comment.find(@reply.comment_id)
        @user = User.find(current_user.id)
    end

    def new
        @reply = Reply.new
    end

    def create
        @reply = Reply.new(reply_create_params)
        @user = User.find(current_user.id)

        if !@reply.save
            respond_to do |format|
                format.html
                format.json
            end
            render "/p/#{params[:id]}", notice: '投稿できませんでした'
        end
    end

    def update
        if @reply.update(reply_update_params)
            respond_to do |format|
                format.html
                format.json
            end
        else
            render "/p/#{@cmt.post_id}", notice: '更新できませんでした'
        end
    end

    def destroy
        if @reply.destroy
            respond_to do |format|
                format.html
                format.json
            end
        else
            render "/p/#{@cmt.post_id}", notice: '削除できませんでした'
        end
    end

    private
        def reply_create_params
         params.require(:reply).permit(:reply, :comment_id).merge(r_uid: current_user.id)
        end
        def reply_update_params
            params.permit(:reply)
        end

end
