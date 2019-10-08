# frozen_string_literal: true

class User < ActiveRecord::Base
  include RemoveOpeningsInCacheConcern

  ADMIN_ROLE_NAME = "admin"

  has_secure_password validations: false

  belongs_to :role, required: false, inverse_of: :users
  has_many :openings
  has_many :applications

  validates :email, presence: { message: I18n.t("errors.users.email.presence") }
  validates :email, uniqueness: { message: I18n.t("errors.users.email.unique") }
  validates :email, 'valid_email_2/email': { message: I18n.t("errors.users.email.invalid") }
  validates :password, presence: { on: :create, message: I18n.t("errors.users.password.presence") }

  def admin?
    role&.name == ADMIN_ROLE_NAME
  end
end
