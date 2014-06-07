require 'rails_helper'

RSpec.describe ImportsController, :type => :controller do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end
  end

  describe "POST 'create'" do
    it "redirects when data is missing" do
      post 'create'
      expect(response).to redirect_to "/imports"
    end

    it "renders when data is present" do
      post 'create', data: fixture_file_upload('files/example_input_with_errors.tab', 'text/plain')
      expect(response).to be_success
    end
  end

end
