FactoryGirl.define do
  factory :image do
    image File.open(File.join(Rails.root, '/spec/fixtures/files/kim_alexis.jpg'))
  end
end
