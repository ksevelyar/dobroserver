# frozen_string_literal: true

FactoryBot.define do
  factory :page do
    content { 'content' }
    sequence(:title) { |n| "Страница ##{n}" }
    published { true }
    published_at { '2013-08-07 22:43:38' }
    user_id { 1 }

    after(:create) do |post, _|
      create_list(:image, 1, blog_record: post)
    end
  end
end
