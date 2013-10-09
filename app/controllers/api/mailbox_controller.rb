class Api::MailboxController < ApplicationController

  def index
    render json: User.find(params[:user_id]).mailbox
  end


end
