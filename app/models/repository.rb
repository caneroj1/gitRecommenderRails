class Repository < ActiveRecord::Base
  ## ATTRIBUTES
  # id: GitHub unique identifier for this repository
  # watchers: the number of users that starred this repo
  # pushed_at: last date of commit to master
  # keyword_one: most desirable keyword
  # readme_url: url to the raw readme
  # readme_text: text of the readme
  # languages: hash of the language breakdown for the repository
  # private: boolean of whether the repo is private or not
end
