class Recommender::RecommenderActions
  class << self
    def analyze_language(current_user, repository_id)
      repo = Repository.find(repository_id)
      user_languages = current_user.language_breakdown
      repo_languages = repo.language_breakdown
      merged_map = user_languages.to_h.merge(repo_languages.to_h) { |key, v1, v2| (v1 - v2).abs }
      if !merged_map.empty?
        (merged_map.values.inject(:+) * 50).round(2)
      else
        100
      end
    end


    def analyze_readme(current_user, repository_id)
      client = Octokit::Client.new(access_token: current_user.access_token)
      repo = Repository.find(repository_id)

      readme_content = Recommender::Support::Readme.get_readme_content(repo, client).upcase
      update_repository_for_readme(readme_content, repo)
      keyword_score = keyword_weights.each.with_index.inject(100) do |score, (weight, index)|
        if readme_content.include?(current_user.keywords[index].upcase)
          score -= weight
        else
          score -= 0
        end
      end

      keyword_score
    end

    def update_repository_for_readme(readme, repo)
      repo.update(readme_text: readme) if repo.readme_text.nil?
    end

    def keyword_weights
      [36, 28, 20, 12, 4]
    end
  end
end
