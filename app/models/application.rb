# frozen_string_literal: true

require_relative "../uploaders/cover_letter_uploader"
require_relative "../uploaders/resume_uploader"

class Application < ApplicationRecord
  include CoverLetterUploader::Attachment.new(:cover_letter)
  include ResumeUploader::Attachment.new(:resume)

  include RemoveOpeningsInCacheConcern

  belongs_to :applicant, class_name: "User", foreign_key: :user_id
  belongs_to :opening

  validates :applicant, apply_once: true
  validates :applicant, presence: { message: I18n.t("errors.application.applicant.presence") }
  validates :cover_letter, presence: { message: I18n.t("errors.application.cover_letter.presence") }
  validates :resume, presence: { message: I18n.t("errors.application.resume.presence") }
end
