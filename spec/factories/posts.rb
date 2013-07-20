FactoryGirl.define do
  factory :post do
    raw_content "description #cut content"
    sequence(:title) {|n| "Пост ##{n}" }
    published true
    published_at "2013-07-20 12:09:23"
    user_id 1
  end
end
