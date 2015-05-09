require 'net/https'
require 'net/http'
require 'open-uri'

class RedirectsController < ApplicationController
  def handle
    access_token = authenticate_via_github
    if access_token.nil?
      render :error
    else
      id = Octokit::Client.new(access_token: access_token).user.id
      redirect_to "/profile"
    end
  end

  def error

  end

  protected
  def post_params
    { client_id: ENV["client_id"],
      client_secret: ENV["client_secret"],
      code: params[:code] }
  end

  def authenticate_via_github
    uri = URI.parse("https://github.com/login/oauth/access_token")
    uri.query = URI.encode_www_form(post_params)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(uri.request_uri)
    get_access_token(http.request(request).body)
  end

  def get_access_token(body)
    body.split('&')[0].split('=')[1]
  end
end
