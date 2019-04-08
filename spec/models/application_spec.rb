require 'rails_helper'

RSpec.describe Application, type: :model do
  describe "associations" do
    it { should belong_to(:applicant).class_name("User") }
    it { should belong_to(:opening) }
  end

  describe "validations" do
    it { should validate_presence_of(:applicant).with_message(I18n.t("errors.application.applicant.presence")) }
    it { should validate_presence_of(:cover_letter).with_message(I18n.t("errors.application.cover_letter.presence")) }
    it { should validate_presence_of(:resume).with_message(I18n.t("errors.application.resume.presence")) }
  end
end
