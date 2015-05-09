class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Include the users helper in our application controller
  # in order to get access to user authentication methods
  include UsersHelper
end
