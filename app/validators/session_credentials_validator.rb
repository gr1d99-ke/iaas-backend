class SessionCredentialsValidator < ActiveModel::EachValidator
  def validate_each(record, _, value)
    return if value.present?

    record.errors.add(:credentials, I18n.t("errors.invalid_credentials.error_message")) if record.errors[:credentials].blank?
  end
end
