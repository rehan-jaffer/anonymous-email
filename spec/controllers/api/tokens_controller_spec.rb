require 'spec_helper'

describe Api::TokensController do

    it "returns a valid token for authentication, with valid user credentials" do
      post :create, :format => :json, :email => @user.email, :password => @user.password
      token = JSON.parse(response.body)
      token["token"].should_not be_empty
    end

end
