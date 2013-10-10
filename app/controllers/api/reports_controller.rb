class Api::ReportsController < ApplicationController

  def index
  
    report_paginator = RedisPagination.paginate("reports")
    render json: report_paginator.page(params[:page])

  end

end
