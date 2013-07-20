FactoryGirl.define do
  factory :page do
    content "content"
    sequence(:title) {|n| "Страница ##{n}" }
    published true
    published_at "2013-08-07 22:43:38"
    user_id 1
  end
end
