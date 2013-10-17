class Api::ReportsController < ApplicationController

  before_filter :authenticate_api_user!

  def index
  
    page = params[:page].to_i

    if current_api_user.has_role?("admin")
      report_paginator = RedisPagination.paginate("reports")
      render json: report_paginator.page(page)
    else
      raise SecurityError
    end

  end

end
