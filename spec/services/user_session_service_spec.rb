# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserSessionService do
  let(:password) { "1234" }
  let(:user) { FactoryBot.create(:user, password: password) }

  describe "validations" do
    context "when email is blank" do
      let(:service) { described_class.call(email: "", password: "password") }

      it_behaves_like "invalid credentials"
    end

    context "when password is blank" do
      let(:service) { described_class.call(email: "test@email.com", password: "password") }

      it_behaves_like "invalid credentials"
    end

    context "when password and email are present" do
      context "when password is incorrect" do
        let(:service)  { described_class.call(email: user.email, password: "password") }

        it_behaves_like "invalid credentials"
      end

      context "when email does not exist" do
        let(:service)  { described_class.call(email: "invali@email.com", password: password) }

        it_behaves_like "invalid credentials"
      end
    end

    context "when email and password are valid" do

      it "returns user instance" do
        expect(described_class.call(email: user.email, password: password).user).to eq(user)
      end
    end
  end
end

