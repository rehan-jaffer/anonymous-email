require 'spec_helper'
require "rake"

describe User do

  before(:all) do
    rake = Rake::Application.new
    Rake.application = rake
    rake.init
    rake.load_rakefile
    ENV["address"] = @user.anonymous_email
    rake['send_sample_mail'].invoke
    rake['send_mail'].invoke
  end

  it "should be able to create a user and retrieve a uid" do

    @u = User.create(:email => "test@test.com", :password => "testpassword")
    @u.save
    @u.confirm!
    expect(@u.uid.class).should be String

  end

  it "should retrieve a user's mailbox if it contains mail" do
     expect(@user.mailbox(1).class).to be Array
     expect(@user.mailbox(1)).to_not be []
  end

end
