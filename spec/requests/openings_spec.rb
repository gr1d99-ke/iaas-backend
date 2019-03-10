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
      before do
        user = create(:user)
        stub_user(user)
        post openings_path, params: { openings: attributes_for(:opening) }
      end

      it_behaves_like "non admin"
    end
  end

  describe "GET /openings" do
    context "when albums exists" do
      let(:openings) do
        relation = []
        10.times do
          relation << build_stubbed(:opening)
        end
        relation
      end

      specify do
        get openings_path
        expect(response).to have_http_status(200)
      end

      it "returns paginated openings" do
        require "will_paginate/array" # we need to manually invoke paginate on an array so that we can get access to pagination methods
        WillPaginate.per_page = 5
        expect(Opening).to receive(:order).with(created_at: 'desc') { openings }
        expect(openings).to receive(:paginate).and_return(openings.paginate)
        get openings_path
        expect(json_response[:data].size).to eq(5)
      end

      it 'orders by last created opening' do
        create_list(:opening, 2)
        get openings_path
        expect(json_response[:data][0][:id]).to eq(Opening.last.id.to_s)
      end
    end
  end

  describe "GET /openings/:id" do
    context "when opening exists" do
      let(:opening) { build_stubbed(:opening) }

      before { expect(Opening).to receive(:find_by).with(id: opening.id.to_s) { opening } }

      specify do
        get opening_path(opening)
        expect(response).to have_http_status(200)
      end

      it "returns requested album" do
        get opening_path(opening)
        expect(json_response[:data][:id].to_i).to eq(opening.id)
      end
    end

    context "when opening does not exist" do
      specify do
        expect(Opening).to receive(:find_by).with(id: "1").and_return(nil)
        get opening_path(id: 1)
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "PUT /openings/:id" do
    context "when admin can only edit allowed attributes" do
      let(:opening) { create(:opening) }
      let(:new_title) { "new title" }
      let(:new_company) { "new company" }
      let(:new_location) { "new location" }
      let(:new_description) { "new description" }
      let(:new_qualifications) { "new qualifications" }
      let(:new_start_date)  { DateTime.now }
      let(:new_end_date) { DateTime.now.advance(months: 10) }
      let(:attributes) { opening.attributes.dup }

      before do
        # remove attributes that should not be updated
        attributes.delete("id")
        attributes.delete("user_id")
        attributes.delete("start_date")
        attributes.delete("end_date")

        # update attributes that we want to update
        attributes["title"] = new_title
        attributes["company"] = new_company
        attributes["location"] = new_location
        attributes["description"] = new_description
        attributes["qualifications"] = new_qualifications
        attributes["start_date"] = new_start_date
        attributes["end_date"] = new_end_date
      end

      specify do
        admin = create(:admin)
        stub_user(admin)
        put opening_path(opening), params: { openings: attributes }
        expect(response).to have_http_status(200)
      end

      it "updates submitted attributes" do
        admin = create(:admin)
        stub_user(admin)
        put opening_path(opening), params: { openings: attributes }
        updated_opening = json_response[:data][:attributes]
        expect(updated_opening[:title]).to match(new_title)
        expect(updated_opening[:company]).to match(new_company)
        expect(updated_opening[:location]).to match(new_location)
        expect(updated_opening[:description]).to match(new_description)
        expect(updated_opening[:qualifications]).to match(new_qualifications)
      end

      it "does not update start_date and end_date if it breaks validations" do
        admin = create(:admin)
        stub_user(admin)
        attributes = { end_date: DateTime.now.advance(months: -100) }
        put opening_path(opening), params: { openings: attributes }
        expect(response).to have_http_status(422)
        expect(json_response[:errors][:end_date]).to match_array([I18n.t("errors.openings.end_date.invalid")])
      end

      it "returns 404 when opening does not exist" do
        admin = create(:admin)
        stub_user(admin)
        put opening_path(12345678909876543), params: { openings: {}}
        expect(response).to have_http_status(404)
      end

      context "when user is not an admin" do
        before do
          user = create(:user)
          stub_user(user)
          put opening_path(id: 122)
        end

        it_behaves_like "non admin"
      end
    end
  end

  describe "DELETE /openings/:id" do
    it "deletes an opening when it exists" do
      admin = create(:admin)
      stub_user(admin)
      opening = create(:opening)
      delete opening_path(opening)
      expect(response).to have_http_status(204)
      expect(Opening.count).to be_zero
    end

    it "returns 404 when an opening does not exist" do
      admin = create(:admin)
      stub_user(admin)
      delete opening_path(id: 122)
      expect(response).to have_http_status(404)
    end

    context "when user is not an admin" do
      before do
        user = create(:user)
        stub_user(user)
        delete opening_path(id: 122)
      end

      it_behaves_like "non admin"
    end
  end
end
