# frozen_string_literal: true

class Application < ApplicationRecord
  belongs_to :applicant,
             class_name: "User",
             foreign_key: :user_id

  validates :applicant, presence: { message: I18n.t("errors.application.applicant.presence") }
end
