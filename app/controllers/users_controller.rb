class UsersController < ApplicationController
  def languages
    @languages = Recommender::Languages.user_languages(current_user)
    respond_to do |format|
      format.js
    end
  end
end
