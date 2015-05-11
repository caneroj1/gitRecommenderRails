class Recommender::Languages
  class << self
    def get_repositories(access_token)
      @client = Octokit::Client.new(access_token: access_token)
      @client.repositories
    end

    def user_languages(current_user)
      get_repositories(current_user.access_token)
      parse_repo_languages(@client.last_response)
    end

    def user_repos(current_user)
      get_repositories(current_user.access_token)
      parse_repos(@client.last_response)
    end

    def parse_repos(api_response)
      api_response.data.each do |repo|

      end
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
  end
end
