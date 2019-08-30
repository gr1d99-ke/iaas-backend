class UserSessionService
  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Callbacks

  define_model_callbacks :initialize, only: [:after]

  after_initialize :valid?
  after_initialize :authenticate!
  after_initialize :set_user

  attr_accessor :email, :password
  attr_reader :user

  validates :email, session_credentials: true
  validates :password, session_credentials: true

  def initialize(params)
    run_callbacks(:initialize) do
      @email    = params[:email]
      @password = params[:password]
      @user     = nil
    end
  end

  def self.call(params = {})
    new(params)
  end

  private

  def authenticate!
    validates_with UserCredentialsValidator
  end

  def set_user
    return if errors.present?

    instance_variable_set("@user", User.find_by(email: email))
  end
end
