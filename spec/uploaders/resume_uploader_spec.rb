# frozen_string_literal: true

require "rails_helper"

RSpec.describe ResumeUploader do
  let(:application) { FactoryBot.create(:application) }

  it "validates mime type" do
    invalid_resume = File.open(Rails.root.join("spec", "files", "resumes", "invalid", "35.jpg"))
    attacher = described_class::Attacher.new(application, :resume)
    attacher.assign(invalid_resume)
    expect(attacher.errors.size > 0).to be_truthy

  end

  it "promotes to store from cache" do
    valid_resume = File.open(Rails.root.join("spec", "files", "resumes", "valid", "1.pdf"))
    attacher = described_class::Attacher.new(application, :resume)

    attacher.assign(valid_resume)
    expect(attacher.cached?).to be_truthy

    attacher.finalize
    expect(attacher.stored?).to be_truthy
  end
end
