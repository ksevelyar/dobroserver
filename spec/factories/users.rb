FactoryGirl.define do
  factory :user do
    name 'chunky_bacon'
    email 'chunky@bacon.tld'
    password '123456'
    password_confirmation '123456'
  end
end
