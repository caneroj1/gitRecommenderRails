class Repository < ActiveRecord::Base
  ## ATTRIBUTES
  # id: GitHub unique identifier for this repository
  # watchers: the number of users that starred this repo
  # pushed_at: last date of commit to master
  # readme_url: url to the raw readme
  # readme_text: text of the readme
  # languages: hash of the language breakdown for the repository
  # is_private: boolean of whether the repo is private or not

  validates :readme_url, :readme_text, presence: true
end
