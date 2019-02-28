# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Openings", type: :request do
  describe "POST /openings" do
    context "when user is admin" do
      let(:admin) { create(:admin) }

      context "when params are valid" do
        it "responds with 200" do
          stub_user(admin)
          post openings_path, params: { openings: attributes_for(:opening) }
          expect(response).to have_http_status(200)
        end

        it "creates opening" do
          stub_user(admin)
          expect { post openings_path, params: { openings: attributes_for(:opening) } }.to change { Opening.count }.by(1)
        end

        it "tracks admin as the creator" do
          stub_user(admin)
          expect(Opening.count).to be(0)
          post openings_path, params: { openings: attributes_for(:opening) }
          expect(Opening.first.user).to be_eql(admin)
        end
      end

      context "when params are invalid" do
        before do
          stub_user(admin)
          attributes = attributes_for(:opening)
          attributes.delete(:start_date)
          attributes.delete(:end_date)
          post openings_path, params: { openings: attributes }
        end

        it "responds with 422" do
          expect(response).to have_http_status(422)
        end
      end
    end

    context "when user is not an admin" do
      it "responds with 403" do
        user = create(:user)
        stub_user(user)
        post openings_path, params: { openings: attributes_for(:opening) }
        expect(response).to have_http_status(403)
      end
    end
  end
end
