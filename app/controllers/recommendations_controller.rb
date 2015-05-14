class RecommendationsController < ApplicationController
  def recommend
    r = Repository.all.sample
    keyword_score = Recommender::RecommenderActions.analyze_readme(current_user, r.id)
    language_score = Recommender::RecommenderActions.analyze_language(current_user, r.id)
    puts "Score:\n\tKeyword:#{keyword_score}\n\tLanguage:#{language_score}"
  end
end
