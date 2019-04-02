# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Applications" do
  describe "POST /openings/:opening_id/applications" do
    context "when user is not authenticated" do
      let(:opening) { FactoryBot.create(:opening) }

      before { post opening_applications_path(opening), params: {} }

      it_behaves_like "unauthenticated user"
    end

    context "when all required attributes are provided" do
      let(:opening) { FactoryBot.create(:opening) }

      before do
        user = FactoryBot.create(:user)
        stub_user(user)
      end

      it "creates application entry" do
        cover_letter = Rack::Test::UploadedFile.new("spec/files/cover_letters/valid/1.pdf", "application/pdf")
        resume = Rack::Test::UploadedFile.new("spec/files/resumes/valid/1.pdf", "application/pdf")

        post "/applications/cover-letter/upload", params: { file: cover_letter }
        cover_letter_data = json_response.to_json

        post "/applications/resume/upload", params: { file: resume }
        resume_data = json_response.to_json

        post opening_applications_path(opening), params: { application: { cover_letter_data: cover_letter_data, resume_data: resume_data } }

        expect(response).to have_http_status(200)
        expect(opening.applications.size).to eq(1)
        expect(opening.applications[0].cover_letter).not_to be_nil
        expect(opening.applications[0].resume).not_to be_nil
      end
    end

    context "when cover letter data is invalid" do
      let(:opening) { FactoryBot.create(:opening) }

      before do
        # authenticate user
        user = FactoryBot.create(:user)
        stub_user(user)

        # upload cover letter
        cover_letter = Rack::Test::UploadedFile.new(Rails.root.join("spec", "files", "cover_letters", "invalid", "35.jpg"), "image/jpeg")
        post "/applications/cover-letter/upload", params: { file: cover_letter }
        cover_letter_data = json_response.to_json

        # attach cover letter data to application
        post opening_applications_path(opening), params: { application: { cover_letter_data: cover_letter_data } }
      end

      it_behaves_like "unprocessable entity"

      it "returns error message in json response" do
        expect(json_response[:errors][:cover_letter].size > 0).to be_truthy
      end
    end

    context "when resume data is invalid" do
      let(:opening) { FactoryBot.create(:opening) }

      before do
        # authenticate user
        user = FactoryBot.create(:user)
        stub_user(user)

        # upload resume
        cover_letter = Rack::Test::UploadedFile.new(Rails.root.join("spec", "files", "resumes", "invalid", "35.jpg"), "image/jpeg")
        post "/applications/cover-letter/upload", params: { file: cover_letter }
        resume_data = json_response.to_json

        # attach resume data to application
        post opening_applications_path(opening), params: { application: { resume_data: resume_data } }
      end

      it_behaves_like "unprocessable entity"

      it "returns error message in json response" do
        expect(json_response[:errors][:resume].size > 0).to be_truthy
      end
    end
  end
end
