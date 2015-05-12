class WelcomeController < ApplicationController
  ## GET
  # root url of the application
  def index
    @authorization_url = "https://github.com/login/oauth/authorize"
    @authorization_url += "?client_id=#{ENV["client_id"]}"
    @authorization_url += "&scope=#{ENV["scopes"]}"
    @authorization_url += "&state=#{ENV["state"]}"
  end
end
