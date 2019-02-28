FactoryBot.define do
  factory :opening do
    title { Faker::Lorem.unique.word }
    company { Faker::Company.unique.name }
    location { Faker::Address.unique.state }
    description { Faker::Lorem.unique.paragraph }
    qualifications { Faker::Lorem.unique.paragraph }
    start_date { DateTime.tomorrow }
    end_date { DateTime.tomorrow.advance(months: -3) }
  end
end
