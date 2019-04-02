# frozen_string_literal: true

require "rails_helper"

RSpec.describe CoverLetterUploader do
  let(:application) { FactoryBot.create(:application) }

  it "validates mime type" do
    invalid_cover_letter = File.open(Rails.root.join("spec", "files", "cover_letters", "invalid", "35.jpg"))
    attacher = described_class::Attacher.new(application, :cover_letter)
    attacher.assign(invalid_cover_letter)
    expect(attacher.errors.size > 0).to be_truthy
  end

  it "promotes to store from cache" do
    valid_cover_letter = File.open(Rails.root.join("spec", "files", "cover_letters", "valid", "1.pdf"))
    attacher = described_class::Attacher.new(application, :cover_letter)

    attacher.assign(valid_cover_letter)
    expect(attacher.cached?).to be_truthy

    attacher.finalize
    expect(attacher.stored?).to be_truthy
  end
end
