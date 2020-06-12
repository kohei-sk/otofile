class OnemessagesController < ApplicationController
  before_action :sign_in_required
  before_action :msg_check

  def msg_check
    @msg = Onemessage.find_by(user_id: current_user.id)
  end

  def new
    if @msg
      redirect_to "/m/edit"
    else
      @msg = Onemessage.new
    end
  end
  def create
    @msg = Onemessage.new(onemessage_params)
    if @msg.save
      redirect_to "/#{current_user.userid}", notice: '更新しました'
    else
      render "onemessages/new"
    end
  end

  def edit
    if !@msg
      redirect_to "/m/new"
    end
  end

  def update
    if @msg.update(onemessage_params)
      redirect_to "/#{current_user.userid}", notice: '更新しました'
    else
      render "onemessages/edit"
    end
  end

  private
    def onemessage_params
      params.require(:onemessage).permit(:message).merge(user_id: current_user.id)
    end

end
