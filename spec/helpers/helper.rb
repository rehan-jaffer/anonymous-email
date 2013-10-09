module TokenHelper
  def self.get_auth_token
      random_seed = rand(99999999999999).round()
      @user = User.create(:email => "test#{random_seed}@test.com", :password => "testpassword")
      @user.confirm!
      post :create, :format => :json, :email => @user.email, :password => @user.password
      token = JSON.parse(response.body)
      return token["token"]
  end
end
