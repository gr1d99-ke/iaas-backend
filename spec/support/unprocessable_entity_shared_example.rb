# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "unprocessable entity" do
  it "returns status code 422" do
    expect(response).to have_http_status(422)
  end
end
