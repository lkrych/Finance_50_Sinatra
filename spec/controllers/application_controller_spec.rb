require 'spec_helper'


RSpec.describe "Application Controller", :type => :controller do
  describe "GET /" do
    it "responds with a status 200 code" do
      get '/'
      expect(last_response.status).to be(200)
    end

    it "renders the home page view, 'home.haml'" do
      get '/'
      expect(last_response.body).to include("Welcome to C$50 Finance")
    end
  end
end
