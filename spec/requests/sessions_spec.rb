require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "POST /sessions" do
    context "when email and password are valid" do
      let(:email) { "test@domain.com" }
      let(:password) { "testpasswsord" }
      let(:valid_params) do
        { email: email,
          password: password }
      end

      before { create(:user, email: email, password: password) }

      it "returns auth token in header" do
        post sessions_path, params: { sessions: valid_params }
        expect(response.headers.keys).to include("X-Access-Token")
        expect(response.headers["X-Access-Token"]).not_to be_nil
      end
    end

    context "when email is not registered" do
      it "returns error message" do
        post sessions_path, params: { sessions: { email: "user@domain.com", password: "1234" } }
        expect(json_response[:errors]).to include(I18n.t("errors.unauthorized.error_message"))
      end

      specify do
        post sessions_path, params: { sessions: { email: "user@domain.com", password: "1234" } }
        expect(response).to have_http_status(401)
      end
    end

    context "when request object is not wrapperd with required key" do
      specify do
        post sessions_path, params: { email: "user@email.com", password: "pass" }
        expect(response).to have_http_status(400)
      end
    end
  end
end
