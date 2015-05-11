FactoryGirl.define do |f|
  factory :user do
    github_id     { rand(100) }
    login         { FFaker::Internet.user_name }
    avatar_url    { FFaker::Internet.http_url }
    keyword_one   { Support::User.keyword }
    keyword_two   { Support::User.keyword }
    keyword_three { Support::User.keyword }
    keyword_four  { Support::User.keyword }
    keyword_five  { Support::User.keyword }
  end
end
