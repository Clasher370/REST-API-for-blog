FactoryGirl.define do
  factory :user do
    nickname { Faker::Name.name }
    email 'example@mail.com'
    password 'secret'
  end
end
