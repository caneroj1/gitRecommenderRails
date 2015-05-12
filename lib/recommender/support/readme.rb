class Recommender::Support::Readme
  class << self
    def get_readme_content(repository, client)
      if repository.readme_text.nil?
        Base64.decode64(client.readme(repository.name).content)
      else
        repository.readme_text
      end
    end
  end
end
