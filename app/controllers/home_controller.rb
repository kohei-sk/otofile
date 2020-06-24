class HomeController < ApplicationController
  def index
    if !user_signed_in?
      redirect_to "/welcome/"
    else
      @f_users = Follow.where(user_id: current_user.id).map { |user| user.f_id.to_i }

      @posts = Post.where(user_id: @f_users).order(created_at: "DESC").page(params[:timeline]).without_count.per(3)

      notice_items = []

      profiles = Profile.where(user_id: @f_users).order(created_at: "DESC").limit(30).to_a
      if !profiles.empty?
        notice_items.push(profiles)
      end

      omsgs = Onemessage.where(user_id: @f_users).order(created_at: "DESC").limit(30).to_a
      if !omsgs.empty?
        notice_items.push(omsgs)
      end

      @notice_items = notice_items.flatten!.sort_by! { |a| a[:updated_at] }.reverse!

      @reco_users = User.where.not(id: current_user.id).order("RANDOM()").limit(30)

      @fing_users = Follow.where(user_id: current_user.id).order(created_at: "DESC").page(params[:following]).without_count.per(15)
      @fer_users = Follow.where(f_id: current_user.id).order(created_at: "DESC").page(params[:follower]).without_count.per(15)

      # post = User.joins(:profiles, :onemessages, :posts)
      # #@posts = post.select("profiles.user_id AS prf_id", "onemessages.user_id AS omsg_id", "posts.user_id AS post_id").where(["prf_id = ? OR omsg_id = ? OR post_id = ?", f_users, f_users, f_users])
      # @posts = post.select("profiles.id AS prf_id", "profiles.free_area", "onemessages.id AS omsg_id", "onemessages.message").where(profiles: { user_id: f_users })
      #   .or(post.select("profiles.id AS prf_id", "profiles.free_area", "onemessages.id AS omsg_id", "onemessages.message").where(onemessages: { user_id: f_users }))

      #.where(["free_area LIKE ? OR trendartist LIKE ? OR trendsong LIKE ? OR fvcate LIKE ? OR fvartist LIKE ? OR fvsong LIKE ? OR fes_sche LIKE ? OR fes_his LIKE ? OR event LIKE ?", "%#{@w}%", "%#{@w}%", "%#{@w}%", "%#{@w}%", "%#{@w}%", "%#{@w}%", "%#{@w}%", "%#{@w}%", "%#{@w}%"])

      # u_post = []

      # f_users.each do |f_user|
      #   post = Post.where(user_id: f_user.f_id).to_a
      #   if !post.empty?
      #     u_post.push(post)
      #   end
      # end

      # from = Time.current.at_beginning_of_day
      # to = (from + 3.day).at_end_of_day

      # f_users.each do |f_user|
      #   prf = Profile.find_by(user_id: f_user.f_id, updated_at: from...to)
      #   if !prf.nil?
      #     u_post.push(prf)
      #   end
      # end

      # f_users.each do |f_user|
      #   msg = Onemessage.find_by(user_id: f_user.f_id, updated_at: from...to)
      #   if !msg.nil?
      #     u_post.push(msg)
      #   end
      # end

      # if u_post.empty?
      #   @posts = []
      # else
      #   posts = u_post.flatten!.sort_by! { |a| a[:updated_at] }.reverse!
      #   @posts = Kaminari.paginate_array(posts).page(params[:timeline]).per(3)
      # end

      ##########

      #   f_users = Follow.where(user_id: current_user.id)

      #   users_list = f_users.map { |user| user.f_id.to_i }

      #   user = User.where(id: users_list)
      #   user.profiles

      #   posts_list = User.left_joins(:profiles, :onemessages, :posts).select("profiles.user_id AS prf_id, onemessages.user_id AS omsg_id, posts.user_id AS post_id").where(["prf_id = ? OR omsg_id = ? OR post_id = ?", users_list, users_list, users_list]).order(created_at: "DESC")

      #   @posts = posts_list
      #     .merge(Profile.where(user_id: users_list))
      #     .merge(Onemessage.where(user_id: users_list))
      #     .merge(Post.where(user_id: users_list))

      #   @posts = posts_list

      #   users_list = [1, 2]
      #   all_posts = User.includes(:profiles).includes(:onemessages).includes(:posts)
      #   all_posts.where(profiles: { user_id: users_list }).or(User.includes(:profiles).includes(:onemessages).includes(:posts).where(onemessages: { user_id: users_list }).or(User.includes(:profiles).includes(:onemessages).includes(:posts).where(posts: { user_id: users_list })

      #   @posts = posts_list.select("profiles.user_id AS prf_id, onemessages.user_id AS oms_id, posts.user_id AS post_id").where(["user_id = ? ", users_list]).order(created_at: "DESC")
    end
  end
end
