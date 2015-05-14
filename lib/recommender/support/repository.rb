class Recommender::Support::Repository
  class << self
    def score(repositories, user)
      repos_and_scores = []

      repositories.each { |repo| repos_and_scores << [repo.score(user), repo] }
      repos_and_scores.sort { |a, b| a[0] <=> b[0] }[0..4]
    end

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

    def get_languages(access_token, repository_id)
      client = Octokit::Client.new(access_token: access_token)
      language_hash = {}

      client.languages(repository_id).to_h
    end

    def add(repository, github_id, client)
      client.stargazers(repository.full_name)
      stargazer_response = client.last_response

      readme_url = nil
      begin
        readme_url = client.readme(repository.full_name).download_url
      rescue => e
        puts "Error: #{e}"
      end

      if readme_url
        Repository.new( id: repository.id,
                        name: repository.full_name,
                        watchers: get_number_of_watchers(stargazer_response),
                        pushed_at: get_last_commit_time(repository.full_name, repository["default_branch"], client),
                        readme_url: readme_url,
                        is_forked: repository.fork,
                        is_private: repository.private,
                        description: repository.description,
                        belongs_to_on_github: github_id)
      else
        false
      end
    end
  end
end
