class Api::MailboxController < ApplicationController

  def index

    if params[:page].nil?
      page = 0
    else
      page = params[:page] 
    end

    render json: current_api_user.mailbox(page)
  end

end
