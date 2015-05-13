class Repository < ActiveRecord::Base
  ## ATTRIBUTES
  # id: GitHub unique identifier for this repository
  # watchers: the number of users that starred this repo
  # pushed_at: last date of commit to master
  # readme_url: url to the raw readme
  # readme_text: text of the readme
  # languages: hash of the language breakdown for the repository
  # is_private: boolean of whether the repo is private or not

  validates :readme_url, presence: true
  belongs_to :user

  def language_breakdown
    total = language_total
    languages.to_a.map { |lang| [lang[0], lang[1].to_i / language_total] }
  end

  def language_total
    language_values.inject(0.0) { |sum, next_value| sum += next_value }
  end

  def language_values
    languages.values.map { |value| value.to_i }
  end
end
