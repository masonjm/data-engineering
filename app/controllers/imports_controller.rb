class ImportsController < ApplicationController
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
