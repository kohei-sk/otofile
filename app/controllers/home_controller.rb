class HomeController < ApplicationController
  def index
    if !user_signed_in?
      redirect_to "/welcome/"
    else
      f_users = Follow.where(user_id: current_user.id)
      u_post = []

      f_users.each do |f_user|
        post = Post.where(user_id: f_user.f_id).to_a
        if !post.empty?
          u_post.push(post)
        end
      end

      from = Time.current.at_beginning_of_day
      to = (from + 3.day).at_end_of_day

      f_users.each do |f_user|
        prf = Profile.find_by(user_id: f_user.f_id, updated_at: from...to)
        if !prf.nil?
          u_post.push(prf)
        end
      end

      f_users.each do |f_user|
        msg = Onemessage.find_by(user_id: f_user.f_id, updated_at: from...to)
        if !msg.nil?
          u_post.push(msg)
        end
      end

      if u_post.empty?
        @posts = u_post
      else
        @posts = u_post.flatten!.sort_by! { |a| a[:updated_at] }.reverse!
      end

      @fing_users = Follow.where(user_id: current_user.id)
      @fer_users = Follow.where(f_id: current_user.id)

      @reco_users = User.where.not(id: current_user.id).order("RANDOM()").limit(30)
    end
  end
end
