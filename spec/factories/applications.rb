FactoryBot.define do
  factory :application do
    association :applicant, factory: :user
    opening
  end
end
