class Api::RegistrationsController < Devise::RegistrationsController

  respond_to :json

  def create

    user = User.create(user_params)

    if user.new_record? == false
      render :json => {"status" => "successfully registered, you have been sent a confirmation email"}, :status=> 200
      return
    else
      render :json => user.errors, :status=>500
    end

  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
