# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'chunky_bacon' }
    sequence(:email) { |n| "user#{n}@bacon.tld" }
    password { '123456' }
    password_confirmation { '123456' }
  end
end
