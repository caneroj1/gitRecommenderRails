class Recommender::Support::Repository
  class << self
    def get_number_of_watchers(api_response)
      return 0 if api_response.data.count.eql?(0)
      return api_response.data.count if api_response.rels.empty?
      number_of_pages = api_response.rels[:last].href.match(/page=(\d+)$/)[1].to_i
      count_on_last_page = api_response.rels[:last].get.data.count.to_i
      (count_on_last_page + (number_of_pages - 1) * 30)
    end

    def get_last_commit_time(repo_name, main_branch = nil, client)
      main_branch ||= "master"
      client.branch(repo_name, main_branch)[:commit][:commit][:author][:date]
    end

    def get_languages(api_response)
      language_hash = {}

      api_response.each { |key, value| language_hash.store(key, value) }
      language_hash
    end

    def add(repository, github_id, client)
      client.stargazers(repository.full_name)
      stargazer_response = client.last_response

      Repository.new( id: repository.id,
                      name: repository.full_name,
                      watchers: get_number_of_watchers(stargazer_response),
                      pushed_at: get_last_commit_time(repository.full_name, repository["default_branch"], client),
                      languages: get_languages(client.languages(repository.full_name)),
                      readme_url: client.readme(repository.full_name).download_url,
                      belongs_to_on_github: github_id)
    end
  end
end
