FactoryBot.define do
  factory :application do
    association :applicant, factory: :user
    opening
    cover_letter { File.open(Rails.root.join("spec", "files", "resumes", "valid", "1.pdf")) }
    resume       { File.open(Rails.root.join("spec", "files", "resumes", "valid", "1.pdf")) }
  end
end
