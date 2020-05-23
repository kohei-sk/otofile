class OnemessagesController < ApplicationController

  def new
    msg = Onemessage.find_by(onemessage_uid: current_user.id)
    if msg
      redirect_to "/m/edit"
    else
      @msg = Onemessage.new
    end
  end
  def create
    @msg = Onemessage.new(onemessage_params)
    if @msg.save
      redirect_to root_path, notice: '更新しました'
    else
      render "onemessages/new"
    end
  end

  def edit
    @msg = Onemessage.find_by(onemessage_uid: current_user.id)
    if !@msg
      redirect_to "/m/new"
    end
  end

  def update
    @msg = Onemessage.find_by(onemessage_uid: current_user.id)
    if @msg.update(onemessage_params)
      redirect_to root_path, notice: '更新しました'
    else
      render "onemessages/edit"
    end
  end

  private
    def onemessage_params
      params.require(:onemessage).permit(:message).merge(onemessage_uid: current_user.id)
    end

end
