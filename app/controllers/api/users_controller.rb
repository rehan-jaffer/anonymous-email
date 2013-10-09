class Api::UsersController < ApplicationController

  def index
    render json: User.all.order(:email).page(params[:page])
  end

end
