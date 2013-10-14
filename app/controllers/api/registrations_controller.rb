class Api::RegistrationsController < Devise::RegistrationsController

  respond_to :json

  def create

    user = User.new(user_params)

    if user.save
      render :json => {"status" => "successfully registered, you have been sent a confirmation email"}.to_json, :status=>201
      return
    else
      warden.custom_failure!
      render :json => user.errors, :status=>422
    end

  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
