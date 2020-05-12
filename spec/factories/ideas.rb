FactoryBot.define do
  factory :idea do
    title { Faker::Lorem.question  }
    description { Faker::Hacker.say_something_smart  }
    user
  end
end
