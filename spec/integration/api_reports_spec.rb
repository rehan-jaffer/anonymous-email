require 'spec_helper'

describe "Test Reporting" do

  before(:all) do
    post "/api/tokens.json", :user => {:email => @user.email, :password => @user.password}
    expect(response).to be_success
    @token = JSON.parse(response.body)["token"]
  end

  it "should not allow viewing of reports if user does not have admin role" do
    expect { get("/api/reports.json?auth_token=#{@token}") }.to raise_error SecurityError
  end

  it "should allow viewing of reports if user does not have admin role" do
    @user.make_admin!
    get "/api/reports.json?auth_token=#{@token}"
    expect(response).to be_success
    expect(JSON.parse(response.body).class).to be Hash
  end

end
