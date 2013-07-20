FactoryGirl.define do
  factory :comment do
    name "MyString"
    email "chunky@bacon.tld"
    content "MyText"

    subject ""
    nickname ""
  end
end
