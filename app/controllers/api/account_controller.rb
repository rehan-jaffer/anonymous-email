class Api::AccountController < ApplicationController

  respond_to :json

  def index

    unless current_api_user.nil?
      render json: current_api_user.to_json
    else
      render :status => 500, :text => "You are not signed in", :layout => nil
    end

  end

  def show


  end

end
