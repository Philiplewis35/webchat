class ChannelsController < ApplicationController
  before_action :set_channel, only: [:show, :edit, :update, :destroy]

  def index
    @channels = Channel.all
    @admin = current_user.admin?
  end

  def new
    @channel = Channel.new
  end

  def create
    if Channel.create!(channel_params)
      flash[:success]= t('create.success', record: "channel")
    else
      flash[:error]= t('create.error', record: "channel")
    end
    redirect_to root_path
  end

  def update
    if @channel.update!(channel_params)
      flash[:success]= t('update.success', record: "channel")
    else
      flash[:error]= t('update.error', record: "channel")
    end
    redirect_to channel_path(@channel)
  end

  def destroy
    if @channel.destroy!
      flash[:success]= t('destroy.success', record: "channel")
    else
      flash[:error]= t('destroy.error', record: "channel")
    end
    redirect_to root_path
  end

  def edit
  end

  private

  def set_channel
    @channel = Channel.find(params[:id])
  end

  def channel_params
    params.require(:channel).permit!
  end
end
