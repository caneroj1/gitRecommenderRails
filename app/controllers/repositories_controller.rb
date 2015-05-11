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
end
