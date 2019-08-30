# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "invalid credentials" do
  it "returns invalid credentials error" do
    expect(service.errors.messages.values.flatten).to include(I18n.t("errors.invalid_credentials.error_message"))
  end
end
