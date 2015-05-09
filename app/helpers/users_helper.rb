module UsersHelper
  def current_user
    User.find(session[:id])
  end

  def user_signed_in?
    !session[:id].nil?
  end
end
