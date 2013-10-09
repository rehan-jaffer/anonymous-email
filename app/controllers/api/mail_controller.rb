require 'redis'
require 'json'

class Api::MailController < ApplicationController

  protect_from_forgery :except => [:create]

  def create

      if ENV['TEST_MODE'].nil?
        data = JSON.parse(params[:mandrill_events])

      else

        data = ""

        File.open("mail_data.txt", "r") do |f|
          data = JSON.parse(f.read)
        end

      end

      Mailbox.add(data)

      render :status => 200, :text => nil, :layout => nil

     return
  end

  def new
  end

  def edit
  end

  def show
    render json: current_api_user.get_mail(params[:guid], current_api_user.uid)
    return
  end

end
