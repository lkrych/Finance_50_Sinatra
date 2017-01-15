require 'spec_helper'


RSpec.describe "Application Controller", :type => :controller do
  
  describe "GET /" do
    it "responds with a status 200 code" do
      get '/'
      expect(last_response.status).to be(200)
    end

    it "renders the home page view, 'home.haml'" do
      get '/'
      expect(last_response.body).to include("Please sign up or log in to use the stock simulator")
    end
  end
  
  describe "GET /registrations/signup" do
    it "responds with a status 200 code" do
      get '/registrations/signup'
      expect(last_response.status).to be(200)
    end

    it "renders the template, 'registrations/signup.haml' " do
      get '/registrations/signup'
      expect(last_response.body).to include("Enter your information to sign up for C$50 Finance")
    end
  end
  
  describe "GET /sessions/login" do
    it "responds with a status 200 code" do
      get '/sessions/login'
      expect(last_response.status).to be(200)
    end

    it "renders the template, 'sessions/login.haml' " do
      get '/sessions/login'
      expect(last_response.body).to include("Enter your information to log in to C$50 Finance")
    end
  end
  
  describe "GET /sessions/logout" do
    it "responds with a status 302 code (redirect)" do
      get '/sessions/logout'
      expect(last_response.status).to be(302)
    end
  end
  
  
end
