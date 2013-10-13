class Api::MailboxController < ApplicationController

#  before_filter :authenticate_user!

  def index

    if params[:page].nil?
      page = 0
    else
      page = params[:page].to_i
    end

    render json: current_api_user.mailbox(page)
  end

end
