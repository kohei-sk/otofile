class FriendsController < ApplicationController
  before_action :sign_in_required

  def show
    f_users = Follow.where(f_id: current_user.id)
    u_post = []
    f_users.each do |f_user|
      post = Post.where(p_userid: f_user.u_id).to_a
      if !post.empty?
        u_post.push(post)
      end
    end
    from = Time.current.at_beginning_of_day
    to = (from + 3.day).at_end_of_day
    f_users.each do |f_user|
      prf = Profile.find_by(profile_uid: f_user.u_id, updated_at: from...to)
      if prf != nil
        u_post.push(prf)
      end
    end
    f_users.each do |f_user|
      msg = Onemessage.find_by(onemessage_uid: f_user.u_id, updated_at: from...to)
      if msg != nil
        u_post.push(msg)
      end
    end

    @post = u_post.flatten!.sort_by! { |a| a[:updated_at] }.reverse!

    @fing_users = Follow.where(f_id: current_user.id)
    @fer_users = Follow.where(u_id: current_user.id)

    @reco_users = User.order("RANDOM()").limit(3)
  end
end
