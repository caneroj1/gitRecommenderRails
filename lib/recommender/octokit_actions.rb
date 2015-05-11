class Recommender::OctokitActions
  class << self
    def get_repositories(access_token)
      @client = Octokit::Client.new(access_token: access_token)
      @client.repositories
    end

    def user_languages(current_user)
      if current_user.language_breakdown.empty?
        get_repositories(current_user.access_token)
        parse_repo_languages(@client.last_response)
      else
        current_user.language_breakdown
      end
    end

    def user_repos(current_user)
      if current_user.repositories.empty?
        get_repositories(current_user.access_token)
        parse_repos(@client.last_response, current_user)
      else
        current_user.repositories
      end
    end

    def parse_repos(api_response, current_user)
      loop do
        api_response.data.each do |repo|
          saved_repo = Repository.find_by_id(repo.id)

          if repo_exists_but_is_not_linked(saved_repo)
            current_user.repositories << saved_repo
            saved_repo.update(belongs_to_on_github: current_user.github_id)
          elsif user_does_not_own_repo(current_user, saved_repo)
            repo_to_add = Recommender::Support::Repository.add(repo, current_user.github_id, @client)
            current_user.repositories << repo_to_add if repo_to_add
          end
        end

        break if api_response.rels[:next].nil?
        api_response = api_response.rels[:next].get
      end

      current_user.repositories
    end

    def parse_repo_languages(api_response)
      languages = {}
      total = 0.0

      loop do
        api_response.data.each do |repo|
          @client.languages(repo.full_name).each do |language, number|
            languages[language] ||= 0
            languages[language] += number
            total += number
          end
        end
        break if api_response.rels[:next].nil?
        api_response = api_response.rels[:next].get
      end

      format_languages(languages, total)
    end

    def format_languages(languages, total)
      languages.to_a.map { |language| [ language[0].to_s, (language[1] / total).round(2)]}
    end

    protected
    def repo_exists_but_is_not_linked(repo)
      repo && !repo.try(:user_id)
    end

    def user_does_not_own_repo(current_user, repo)
      !current_user.repositories.find_by_id(repo.try(:id))
    end
  end
end
