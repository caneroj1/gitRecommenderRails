class RepositoriesController < ApplicationController
  def languages
    @id = params[:id]
    repo = Repository.find(@id)
    @languages = Recommender::Support::Repository.get_languages(current_user.access_token, repo.name)
    repo.languages = @languages
    repo.save

    respond_to do |format|
      format.js
    end
  end

  def analyze_readme
    @keyword_score = Recommender::RecommenderActions.analyze_readme(current_user, params[:id])

    respond_to do |format|
      format.js
      format.json { render json: { score: @keyword_score } }
    end
  end
end
