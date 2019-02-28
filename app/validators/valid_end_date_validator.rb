# frozen_string_literal: true

class ValidEndDateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    start_date = record.send(:start_date)
    return unless value.present? && start_date.present?

    return if value > start_date

    record.errors.add(attribute, I18n.t("errors.openings.end_date.invalid"))
  end
end
