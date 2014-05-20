FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password "treehouse1"
    password_confirmation "treehouse1"
    organizer true
  end

  factory :group do
    name "Groupname"
    creation_date "2012-02-01"
    after(:create) {|group| group.user = [create(:user)]}
  end
end
