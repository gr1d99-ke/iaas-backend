require 'rails_helper'

RSpec.describe Role, type: :model do
  it { should have_many(:users) }
  it { should validate_presence_of(:name).with_message(I18n.t("errors.roles.name.presence")) }
  it { should_not allow_value("student").for(:name).with_message(I18n.t("errors.roles.name.invalid", value: "student")) }
  it { should allow_value("admin").for(:name) }
end
