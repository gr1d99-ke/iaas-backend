# frozen_string_literal: true

require "rails_helper"

RSpec.describe Opening, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:applications) }
  end

  describe "validations" do
    it { should allow_value(nil).for(:user) }

    it { should validate_presence_of(:title).with_message(I18n.t("errors.openings.title.presence")) }

    it { should validate_presence_of(:company).with_message(I18n.t("errors.openings.company.presence")) }

    it { should validate_presence_of(:location).with_message(I18n.t("errors.openings.location.presence")) }

    it { should validate_presence_of(:description).with_message(I18n.t("errors.openings.description.presence")) }

    it { should validate_presence_of(:qualifications).with_message(I18n.t("errors.openings.qualifications.presence")) }

    it { should validate_presence_of(:start_date).with_message(I18n.t("errors.openings.start_date.presence")) }

    it { should validate_presence_of(:end_date).with_message(I18n.t("errors.openings.end_date.presence")) }

    it "ensures end date is greater than start date" do
      opening = build(:opening)
      start_date = DateTime.tomorrow
      end_date = start_date.advance(months: -1)
      opening.end_date = end_date
      opening.save

      expect(opening.valid?).not_to be_truthy
      expect(opening.errors[:end_date]).to include(I18n.t("errors.openings.end_date.invalid"))
    end
  end
end
