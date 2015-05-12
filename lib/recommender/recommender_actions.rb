class Recommender::RecommenderActions
  class << self
    def analyze_my_readmes(current_user)
      client = Octokit::Client.new(access_token: current_user.access_token)
      my_repositories = Repository.where("user_id = ?", current_user.id)

      my_repositories.each do |repo|
        readme_content = Recommender::Support::Readme.get_readme_content(repo, client).upcase
        update_repository_for_readme(readme_content, repo)
        current_user.user_keywords.each { |keyword| puts "#{keyword} => #{readme_content.include?(keyword.upcase)}" }
      end
    end

    def update_repository_for_readme(readme, repo)
      repo.update(readme_text: readme) if repo.readme_text.nil?
    end
  end
end
