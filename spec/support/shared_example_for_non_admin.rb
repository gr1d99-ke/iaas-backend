# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "non admin" do
  it "returns status code 403" do
    expect(response).to have_http_status(403)
  end
end
