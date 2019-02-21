require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /users" do
    let(:password) { Faker::Internet.password(6) }

    context "when valid email and password are provided" do
      let(:user_params) { attributes_for(:user).merge(password: password) }

      it "creates user" do
        expect { post users_path, params: { user: user_params } }.to change { User.count }.by(1)
      end


      it "returns status code 201" do
        post users_path, params: { user: user_params }
        expect(response).to have_http_status(201)
      end

      it "returns user token in header" do
        post users_path, params: { user: user_params }
        expect(response.headers.keys).to include("x-access-token")
        expect(response.headers["x-access-token"]).not_to be_nil
      end
    end

    context "when email is invalid" do
      let(:invalid_params) { { email: "email", password: password } }

      specify do
        post users_path, params: { user: invalid_params }
        expect(response).to have_http_status(422)
      end

      it "returns error response" do
        post users_path, params: { user: invalid_params }
        expect(json_response[:status]).to match("422")
        expect(json_response[:errors][:email]).to match_array(["Email is not valid"])
      end
    end

    context "when password is not provided" do
      let(:invalid_params) { { email: "test@email.com", password: "" } }

      specify do
        post users_path, params: { user: invalid_params }
        expect(response).to have_http_status(422)
      end

      it "returns error response" do
        post users_path, params: { user: invalid_params }
        expect(json_response[:status]).to match("422")
        expect(json_response[:errors][:password]).to include(I18n.t("errors.users.password.presence"))
      end
    end
  end
end
