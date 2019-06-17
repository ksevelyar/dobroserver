# frozen_string_literal: true

FactoryBot.define do
  factory :image do
    image do
      Rack::Test::UploadedFile.new(
        Rails.root.join('spec/fixtures/files/kim_alexis.jpg'), 'image/jpeg'
      )
    end
  end
end
