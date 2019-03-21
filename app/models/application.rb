# frozen_string_literal: true

require_relative "../uploaders/cover_letter_uploader"
require_relative "../uploaders/resume_uploader"

class Application < ApplicationRecord
  include CoverLetterUploader::Attachment.new(:cover_letter)
  include ResumeUploader::Attachment.new(:resume)

  belongs_to :applicant,
             class_name: "User",
             foreign_key: :user_id

  belongs_to :opening

  validates :applicant, presence: { message: I18n.t("errors.application.applicant.presence") }
end
