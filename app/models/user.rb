class User < ActiveRecord::Base
  ## ATTRIBUTES
  # login: GitHub login
  # access_token: GitHub OAuth access token
  # github_id: GitHub unique identifier for account
  # keyword_one: most desirable keyword
  # ....
  # keyword_five: least desirable keyword
  # language_breakdown: array of percentages for each language
  # avatar_url: link to the github avatar

  serialize(:language_breakdown, Array)
  has_many :repositories
end
