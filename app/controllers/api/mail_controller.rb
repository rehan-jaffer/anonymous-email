require 'redis'
require 'json'

class Api::MailController < ApplicationController

  protect_from_forgery :except => [:create]

  def create

    begin
      REDIS.set("sample_post", JSON.parse(params[:mandrill_events]))
      render :status => 200, :text => nil, :layout => nil
    rescue
      render :text => nil, :status => 500
    end
 
     return
  end

  def new
  end

  def edit
  end

  def show
    render text: REDIS.get("sample_post"), layout: nil
    return
  end

end
