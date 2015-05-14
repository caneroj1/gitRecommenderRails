class RecommendationsController < ApplicationController
  def recommend
    repositories = Repository.limit(50).order("RANDOM()")
    @top_five = Recommender::Support::Repository.score(repositories, current_user)
  end
end
