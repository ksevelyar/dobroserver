# frozen_string_literal: true

FactoryBot.define do
  factory :page do
    content { 'content' }
    sequence(:title) { |n| "Page ##{n}" }
    published { true }
    published_at { 1.day.ago }
    user

    after(:create) do |post, _|
      create_list(:image, 1, blog_record: post)
    end
  end
end
