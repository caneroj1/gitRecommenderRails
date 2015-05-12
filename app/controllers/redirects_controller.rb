require 'net/https'
require 'net/http'
require 'open-uri'

class RedirectsController < ApplicationController
  def handle
    access_token = authenticate_via_github
    if access_token.nil?
      render :error
    else
      user = Octokit::Client.new(access_token: access_token).user
      sign_in_or_sign_up_user(user, access_token)
      redirect_to "/profile"
    end
  end

  def error

  end

  protected
  # send a post request to the oauth access token url, and then parse the request body
  def authenticate_via_github
    uri = "https://github.com/login/oauth/access_token"
    body = Recommender::Support::Request.makeSecureGet(uri, post_params)
    get_access_token(body)
  end

  # parse the request body in order to get the access token
  def get_access_token(body)
    body.split('&')[0].split('=')[1]
  end

  # parameters that will be posted to github's oauth url to get an access token
  def post_params
    { client_id: ENV["client_id"],
      client_secret: ENV["client_secret"],
      code: params[:code] }
  end

  # parameters that will be used to create a new user
  def user_params(github_result, access_token)
    { login: github_result.login,
      github_id: github_result.id,
      avatar_url: github_result.avatar_url,
      access_token: access_token }
  end

  # using the github API result we obtained through 'user = Octokit::Client.new(access_token: access_token).user',
  # we either try to find a user that we have already created or create a new one, and sign them in.
  def sign_in_or_sign_up_user(github_result, access_token)
    user = User.try(:find_by_github_id, github_result.id)
    if user
      user.update(access_token: access_token)
    else
      user = User.create(user_params(github_result, access_token))
    end

    session[:id] = user.id
  end
end
