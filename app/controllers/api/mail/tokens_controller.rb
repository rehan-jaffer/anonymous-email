class Api::Mail::TokensController < ApplicationController

  skip_before_filter :verify_authenticity_token
  respond_to :json

  def create
    email = params["user"]["email"]
    password = params["user"]["password"]
    if request.format != :json
      render :status => 406, :json => {:message => "The request must be json"}
      return
    end

    if email.nil? or password.nil?
      render :status => 400,
             :json => {:message => "The request must contain the user email and password."}
      return
    end

    invalidMsg = "Invalid email or password."

    @user = User.find_by_email(email)
    if @user.nil?
      logger.info("User #{email} failed sign-in, user cannot be found.")
      render :status => 401, :json => {:message => invalidMsg}
      return
    end

    @user.ensure_authentication_token!

    if not @user.valid_password?(password)
      logger.info("User #{email} failed signin, invalid password")
      render :status => 401, :json => {:message => invalidMsg}
    else
      render :status => 200, :json => {:token => @user.authentication_token}
    end
  end

  def destroy
    @user = User.find_by_authentication_token(params[:id])
    if @user.nil?
      logger.info('Token not found.')
      render :status=>404, :json=>{:message=> 'Invalid token.'}
    else
      @user.reset_authentication_token!
      render :status=>200, :json=>{:token=>params[:id]}
    end
  end
end
