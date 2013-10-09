class Api::Users::MailController

  def show

  end

  def index
    render json: User.find(params[:id]).mailbox
  end  

end
