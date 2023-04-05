class JsonWebToken
  JWT_SECRET = ENV['JWT_SECRET']
  def self.encode(payload, exp = 1.year.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, JWT_SECRET)
  end

  def self.decode(token)
    body = JWT.decode(token, JWT_SECRET)[0]
    HashWithIndifferentAccess.new body
  rescue JWT::ExpiredSignature, JWT::VerificationError => _e
    return { status: 401,
                   message: 'Authorization Error. Login Expired'
    }
  rescue JWT::DecodeError, JWT::VerificationError => _e
    return { status: 401,
                   message: 'Authorization Error. Invalid Token'
    }
  end
end