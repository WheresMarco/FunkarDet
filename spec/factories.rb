FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}@example.com" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password "treehouse1"
    password_confirmation "treehouse1"
  end
end
