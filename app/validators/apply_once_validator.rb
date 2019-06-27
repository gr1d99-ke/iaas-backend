class ApplyOnceValidator < ActiveModel::EachValidator
  def validate_each(record, _, value)
    opening_id = record&.opening_id
    user_id    = value&.id
    return unless Application.where(user_id: user_id, opening_id: opening_id)&.exists?

    record.errors.add(:user, I18n.t("errors.application.applicant.apply_once"))
  end
end