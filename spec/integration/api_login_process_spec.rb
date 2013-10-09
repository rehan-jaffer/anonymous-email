require 'spec_helper'

describe "Login Process API" do

  before(:all) do
    post "/api/tokens.json", :email => @user.email, :password => @user.password
    expect(response).to be_success
    @token = JSON.parse(response.body)["token"]
  end

  it "checks account details against current user" do
    get "/api/account.json?auth_token=#{@token}"
    expect(response).to be_success
    account = JSON.parse(response.body)
    account["email"].should == @user.email
  end

end

