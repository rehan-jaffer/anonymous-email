require 'spec_helper'

describe "Test API Mailbox functionality" do

  before(:all) do
    post "/api/tokens.json", :user => {:email => @user.email, :password => @user.password}
    expect(response).to be_success
    @token = JSON.parse(response.body)["token"]
  end

  it "should return the user's current mailbox when making a request via the API" do
    get "/api/mailbox.json?auth_token=#{@token}"
    expect(response).to be_success
    mailbox = JSON.parse(response.body)
    expect(mailbox.class).to be Array
  end

  it "should return an arbitrary user's mailbox when making a request via the API" do
    @user.make_admin!
    suffix = rand(99999)
    @test_user = User.create(:email => "temp#{suffix}@user.com", :password => "testpassword")
    @test_user.confirm!

    get "/api/mailbox.json?auth_token=#{@token}&user_id=#{@test_user.id}"
    expect(response).to be_success
    mailbox = JSON.parse(response.body)
    expect(mailbox.class).to be Array
  end

  it "shouldn't return an arbitrary user's mailbox when making a request via the API" do
    @user.unmake_admin!
    suffix = rand(99999)
    @test_user = User.create(:email => "temp#{suffix}@user.com", :password => "testpassword")
    @test_user.confirm!

    expect { get "/api/mailbox.json?auth_token=#{@token}&user_id=#{@test_user.id}" }.to raise_error SecurityError
  end

end

