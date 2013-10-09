require 'spec_helper'

describe "Test API Mailbox functionality" do

  before(:all) do
    post "/api/tokens.json", :email => @user.email, :password => @user.password
    expect(response).to be_success
    @token = JSON.parse(response.body)["token"]
  end

  it "should return the user's current mailbox when making a request via the API" do
    get "/api/users/#{@user.id}/mailbox.json?auth_token=#{@token}"
    expect(response).to be_success
    mailbox = JSON.parse(response.body)
    mailbox.class.should == Array
  end

end

