class Api::ReportsController < ApplicationController

  def index
  
    errors = REDIS.lrange("mail-errors", 0, 10)
    render json: errors

  end

end
