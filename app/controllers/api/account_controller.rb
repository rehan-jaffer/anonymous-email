class Api::AccountController < ApplicationController

  before_filter :authenticate_api_user!

  respond_to :json

  def index

    if current_api_user.has_role?(:admin)
      render json: User.find(params[:user_id]).to_json
      return
    end

    if params[:user_id] && !current_api_user_has_role?(:admin)
      raise SecurityError
    end

    unless current_api_user.nil?
      render json: current_api_user.to_json
    else
      render :status => 500, :text => "You are not signed in", :layout => nil
    end

  end

  def show


  end

end
