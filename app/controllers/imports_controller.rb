class ImportsController < ApplicationController
  # It seems like this is *so* close to working, but ruby-openid keeps choking while processing
  # the response from Google. Might be an incompatibility with Rails 4.1.1.
  #before_action :authenticate_user!
  
  def index
  end

  def create
    data = params[:data]
    if data
      @importer = Importer.new(data.read)
      @importer.import
    else
      redirect_to imports_url, alert: "Data file is required"
    end
  end
end
