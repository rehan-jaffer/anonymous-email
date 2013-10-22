class Api::Mail::MailboxController < ApplicationController

  before_filter :authenticate_api_mail_user!

  def index

    if params[:page].nil?
      page = 0
    else
      page = params[:page].to_i
    end

   if current_api_mail_user.has_role?(:admin)
      render json: User.find(params[:user_id]).mailbox(page).to_json
      return
    end

    if params[:user_id] && !current_api_mail_user.has_role?(:admin)
      raise SecurityError
    end

    if current_api_mail_user.has_role?("admin")
      render json: User.find(params[:id]).to_json
    else
      render json: current_api_mail_user.mailbox(page).to_json
    end
  end

end
