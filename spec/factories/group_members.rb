# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group_member, :class => 'GroupMember' do
    group nil
    name "MyString"
    email "MyString"
  end
end
