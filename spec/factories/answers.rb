# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    association :question, factory: :question
    body Faker::Lorem.sentence
  end
end
