# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'Antonio'
    sequence(:email) {|n| "email_#{n}@example.com"}
    password '123'
  end
end
