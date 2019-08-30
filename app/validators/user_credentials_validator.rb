class UserCredentialsValidator < ActiveModel::Validator
  def validate(record)
    return if record.errors.present?

    resource = User.find_by(email: record.email)&.authenticate(record.password)

    return if resource

    record.errors.add(:credentials, I18n.t("errors.invalid_credentials.error_message"))
  end
end
