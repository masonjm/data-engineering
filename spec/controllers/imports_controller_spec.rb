require 'rails_helper'

RSpec.describe ImportsController, :type => :controller do

  describe "GET 'index'" do
    it "blocks unauthenticated access" do
      sign_in nil
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it "allows authenticated access" do
      sign_in
      get :index
      expect(response).to be_success
    end
  end

  describe "POST 'create'" do
    it "blocks unauthenticated access" do
      sign_in nil
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects when data is missing" do
      sign_in
      post 'create'
      expect(response).to redirect_to "/imports"
    end

    it "renders when data is present" do
      sign_in
      post 'create', data: fixture_file_upload('files/example_input_with_errors.tab', 'text/plain')
      expect(response).to be_success
    end
  end

end
