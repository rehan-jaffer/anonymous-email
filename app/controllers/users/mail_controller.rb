class Users::MailController < ApplicationController

  layout "dashboard"

  before_filter :authenticate_user!

  def index

  end

end
