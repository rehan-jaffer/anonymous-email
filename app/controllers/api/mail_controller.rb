require 'redis'
require 'json'

class Api::MailController < ApplicationController

  respond_to :json

  before_filter :authenticate_api_user!, :except => [:create]

  protect_from_forgery :except => [:create]

  def create

      begin

        data = JSON.parse(params[:mandrill_events])

        check_sender_integrity
 
        Mailbox.add(data)

        render :status => 200, :text => nil, :layout => nil

      rescue SecurityError => e

        Rails.logger.info e.inspect
        render :status => 500, :text => e.inspect, :layout => nil

      end

     return

  end

  def new
  end

  def edit
  end

  def show
    render json: current_api_user.get_mail(params[:id])
    return
  end

end
