class UsersController < ApplicationController
  def update
    if current_user.update(user_params)
      respond_to do |format|
        format.html
        format.js
        format.json { render json: current_user, status: 202 }
      end
    else
      render '/profile'
    end
  end

  def languages
    @languages = Recommender::OctokitActions.user_languages(current_user)
    current_user.update(language_breakdown: @languages)
    respond_to do |format|
      format.js
    end
  end

  def repositories
    @repositories = Recommender::OctokitActions.user_repos(current_user)
    respond_to do |format|
      format.js
    end
  end

  protected
  def user_params
    params.require(:user).permit(:keyword_one, :keyword_two,:keyword_three, :keyword_four, :keyword_five)
  end
end
