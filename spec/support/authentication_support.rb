module AuthenticationSupport
  def stub_user(user)
    allow(JWT).to receive(:decode).and_return(
      [
        {
          "email" => user.email,
          "role" => user.role&.name
        }
      ]
    )
  end
end

RSpec.configure do |config|
  config.include(AuthenticationSupport)
end
