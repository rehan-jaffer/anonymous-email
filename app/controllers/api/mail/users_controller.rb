class Api::Mail::UsersController < ApplicationController

  before_filter :authenticate_api_mail_user!

  def index
    render json: User.all.order(:email).page(params[:page])
  end

end
