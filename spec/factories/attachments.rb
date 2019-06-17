# frozen_string_literal: true

FactoryBot.define do
  factory :attachment do
    attachment do
      Rack::Test::UploadedFile.new(File.join(Rails.root, '/spec/fixtures/files/kim_alexis.jpg'))
    end
  end
end
