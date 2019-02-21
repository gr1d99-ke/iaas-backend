module JwtToken
  class JwtToken
    ALGORITHM = "HS256".freeze

    class << self
      def encode(payload, secret)
        payload = add_claims(payload)

        JWT.encode(payload,
                   secret,
                   JwtToken::ALGORITHM)
      end

      def decode(token, secret)
        JWT.decode(token,
                   secret,
                   true,
                   algorithm: JwtToken::ALGORITHM)
      end

      private

      def add_claims(payload)
        exp = Time.now.to_i + 3600
        payload[:exp] = exp
        payload
      end
    end
  end
end
