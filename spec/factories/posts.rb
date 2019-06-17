# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    raw_content { 'description #cut content' }
    sequence(:title) { |n| "Title ##{n}" }
    published { true }
    published_at { '2013-07-20 12:09:23' }
    user

    after(:create) do |post, _|
      create_list(:image, 1, blog_record: post)
    end
  end
end
