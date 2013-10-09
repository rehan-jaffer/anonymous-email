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

  def index
    render json: User.find(params[:user_id]).mailbox
  end

  def show
    render json: REDIS.hget("mail_#{params[:guid]}")
    return
  end

end
