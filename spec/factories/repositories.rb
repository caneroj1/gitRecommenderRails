FactoryGirl.define do
  factory :repository do
    watchers    { rand(1000) }
    pushed_at   { Date.new }
    readme_url  { FFaker::Internet.http_url }
    readme_text { FFaker::Lorem.paragraph }
    languages   { Support::Repository.languages }
    is_private  { [true, false].sample }
  end
end
