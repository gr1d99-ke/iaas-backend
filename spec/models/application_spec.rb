require 'rails_helper'

RSpec.describe Application, type: :model do
  describe "associations" do
    it { should belong_to(:applicant).class_name("User") }
    it { should belong_to(:opening) }
  end

  describe "validations" do
    it { should validate_presence_of(:applicant).with_message(I18n.t("errors.application.applicant.presence")) }
  end
end
