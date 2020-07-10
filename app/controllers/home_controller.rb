class HomeController < ApplicationController
  def index
    if !user_signed_in?
      redirect_to "/welcome/"
    else
      @f_users = Follow.where(user_id: current_user.id).map { |user| user.f_id.to_i }

      @posts = Post.where(user_id: @f_users).order(created_at: "DESC").page(params[:timeline]).without_count.per(5)

      notice_items = []

      profiles = Profile.where(user_id: @f_users).order(created_at: "DESC").limit(10).to_a
      if !profiles.empty?
        notice_items.push(profiles)
      end

      omsgs = Onemessage.where(user_id: @f_users).order(created_at: "DESC").limit(10).to_a
      if !omsgs.empty?
        notice_items.push(omsgs)
      end

      if notice_items.empty? || notice_items.nil?
        @notice_items = []
      else
        @notice_items = notice_items.flatten!.sort_by! { |a| a[:updated_at] }.reverse!
      end

      @reco_users = User.where.not(id: current_user.id).order("RANDOM()").limit(10)

      @fing_users = Follow.where(user_id: current_user.id).order(created_at: "DESC").page(params[:following]).without_count.per(15)
      @fer_users = Follow.where(f_id: current_user.id).order(created_at: "DESC").page(params[:follower]).without_count.per(15)

      def follow_count
        @fing_users = Follow.where(user_id: current_user.id).length
        @fer_users = Follow.where(f_id: current_user.id).length

        respond_to do |format|
          format.html
          format.json
        end
      end
    end
  end
end
