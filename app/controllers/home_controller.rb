class HomeController < ApplicationController
  before_action :f_users

  def index
    if !user_signed_in?
      redirect_to "/welcome/"
    else
      @f_users = @f_users.push(current_user.id, 5)
      logger.debug(@f_users)
      @posts = Post.where(user_id: @f_users).order(created_at: "DESC").page(params[:timeline]).without_count.per(3)

      @fing_users = Follow.where(user_id: current_user.id).order(created_at: "DESC").page(params[:following]).without_count.per(10)
      @fer_users = Follow.where(f_id: current_user.id).order(created_at: "DESC").page(params[:follower]).without_count.per(10)

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

  def f_users
    if user_signed_in?
      @f_users = Follow.where(user_id: current_user.id).map { |user| user.f_id.to_i }
    end
  end

  def reco_users
    if user_signed_in?
      @reco_users = User.where.not(id: current_user.id).order("RANDOM()").limit(10)

      render partial: "reco_users"
    end
  end

  def notice_items
    if user_signed_in?
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

      render partial: "notice_items"
    end
  end
end
