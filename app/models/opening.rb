# frozen_string_literal: true

class Opening < ApplicationRecord
  belongs_to :user,
             required: false

  validates :title,
            presence: { message: I18n.t("errors.openings.title.presence") }
  validates :company,
            presence: { message: I18n.t("errors.openings.company.presence") }
  validates :location,
            presence: { message: I18n.t("errors.openings.location.presence") }
  validates :description,
            presence: { message: I18n.t("errors.openings.description.presence") }
  validates :qualifications,
            presence: { message: I18n.t("errors.openings.qualifications.presence") }
  validates :start_date,
            presence: { message: I18n.t("errors.openings.start_date.presence") }
  validates :end_date,
            presence: { message: I18n.t("errors.openings.end_date.presence") }
  validates :end_date,
            valid_end_date: { message: I18n.t("errors.openings.end_date.invalid") }

end
