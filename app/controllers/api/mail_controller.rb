class Api::MailController < ApplicationController

  protect_from_forgery :except => [:create]

  def create
    render :status => 200, :text => nil
  end

  def new
  end

  def edit
  end

end
