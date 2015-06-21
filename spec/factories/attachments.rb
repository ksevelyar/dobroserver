FactoryGirl.define do
  factory :attachment do
    attachment File.open(File.join(Rails.root, '/spec/fixtures/files/kim_alexis.jpg'))
  end
end
