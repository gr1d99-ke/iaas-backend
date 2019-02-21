# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "validates presence of email" do
      should validate_presence_of(:email).with_message(I18n.t("errors.users.email.presence"))
    end

    it "validates uniqueness of email" do
      should validate_uniqueness_of(:email).with_message(I18n.t("errors.users.email.unique"))
    end

    it "validates validity of email" do
      should_not allow_value("some fancy email").for(:email).with_message(I18n.t("errors.users.email.invalid"))

      should_not allow_value("email@").for(:email).with_message(I18n.t("errors.users.email.invalid"))

      should_not allow_value("email@domain").for(:email).with_message(I18n.t("errors.users.email.invalid"))

      should_not allow_value("email@domain.").for(:email).with_message(I18n.t("errors.users.email.invalid"))

      should allow_value("email@domain.com").for(:email)
    end

    it "validates presence of password" do
      should validate_presence_of(:password).with_message(I18n.t("errors.users.password.presence"))
    end
  end
end
