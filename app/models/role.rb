# frozen_string_literal: true

class Role < ApplicationRecord
  ROLE_TYPES = %w(admin)

  has_many :users,
           dependent: :nullify,
           inverse_of: :role

  validates :name, presence: { message: I18n.t("errors.roles.name.presence") }
  validates :name, inclusion: { in: ROLE_TYPES, message: I18n.t("errors.roles.name.invalid", value: "%{value}") }
end
