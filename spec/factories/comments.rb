# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    name { 'Commenter' }
    email { 'chunky@bacon.tld' }
    content { 'MyText' }
  end
end
