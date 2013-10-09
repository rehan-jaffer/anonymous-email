require 'spec_helper'
require 'helpers/helper'

describe Api::AccountController do

  describe "#account" do

    it "allows access to the account details via the API" do
      get :account, :auth_token => TokenHelper::get_auth_token
    end

  end

end
