# frozen_string_literal: true

require "rails_helper"

RSpec.describe JwtToken::JwtToken do
  let(:email) { "gideon@gmail.com" }
  let(:secret) { "12345q@" }
  let(:payload) { { email: email } }

  describe ".encode" do
    it "encodes payload and generate token" do
      token = described_class.encode(payload, secret)
      expect(token).not_to be(nil)
    end
  end

  describe ".decode" do
    it "decodes jwt token" do
      token = described_class.encode(payload, secret)
      expect(token).not_to be(nil)
      decoded_token = described_class.decode(token, secret)
      expect(decoded_token[0]["email"]).to match(email)
    end

    it "raises error when token is expired" do
      token = described_class.encode(payload, secret)
      Timecop.freeze(Time.now + 3600) do
        expect { described_class.decode(token, secret) }.
          to raise_error(JWT::ExpiredSignature)
      end
    end

    it "raises error when jwt token is invalid" do
      token = "some string"
      expect { described_class.decode(token, "secret") }
        .to raise_error(JWT::DecodeError)
    end
  end
end
