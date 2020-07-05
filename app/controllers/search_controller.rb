class SearchController < ApplicationController
    before_action :word, except: [ :check, :user_random, :user_random ]

    def check
        if params[:u_search]
        redirect_to "/u/search/#{params[:u_search]}"
        elsif params[:pr_search]
        redirect_to "/pr/search/#{params[:pr_search]}"
        elsif params[:p_search]
        redirect_to "/p/search/#{params[:p_search]}"
        else
        redirect_to "/unmatch/検索ワードがありません"
        end
    end

    def word
        @w = params[:word]
    end

    def user
        @search = User.where(["username LIKE ? OR userid LIKE ?", "%#{@w}%", "%#{@w}%"])
        if @search.empty?
            redirect_to "/unmatch/#{@w}"
        end
    end

    def profile
        prf = Profile.joins(:histories)
        @search = prf.group(:profile_id).select("profiles.*", "histories.*").where(["free_area LIKE ? OR trendartist LIKE ? OR trendsong LIKE ? OR fvcate LIKE ? OR fvartist LIKE ? OR fvsong LIKE ? OR fes_sche LIKE ? OR fes_his LIKE ? OR event LIKE ?", "%#{@w}%", "%#{@w}%", "%#{@w}%", "%#{@w}%", "%#{@w}%", "%#{@w}%", "%#{@w}%", "%#{@w}%", "%#{@w}%"])

        if @search.empty?
            redirect_to "/unmatch/#{@w}"
        end
    end

    def post
        @search = Post.where(["title LIKE ? OR comment LIKE ?", "%#{@w}%", "%#{@w}%"])
        if @search.empty?
            redirect_to "/unmatch/#{@w}"
        end
    end

    def user_random
        if user_signed_in?
            @search = User.where.not(id: current_user.id).order("RANDOM()").limit(1)[0]
        else
            @search = User.order("RANDOM()").limit(1)[0]
        end
        if @search.nil?
            redirect_to root_path
        else
            redirect_to "/#{@search.userid}"
        end
    end

    def post_random
        if user_signed_in?
            @search = Post.where.not(user_id: current_user.id).order("RANDOM()").limit(1)[0]
        else
            @search = Post.order("RANDOM()").limit(1)[0]
        end
        if @search.nil?
            redirect_to root_path
        else
            redirect_to "/p/#{@search.id}"
        end
    end

    def unmatch
    end
end
