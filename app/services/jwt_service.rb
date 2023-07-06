class JwtService

  def initialize(data)
    @user = data[:user]
    @token = data[:token]
  end

  def generate_token
    return unless user
    create_user_token
  end

  def get_current_user
    return unless token
    current_user
  end


  private

  attr_reader :data, :user, :token, :payload

  def create_user_token
    JWT.encode(payload, ENV['JWT_SECRET_TOKEN'], ENV['HASH_CODE'])
  end

  def current_user
    return unless decode_user_token

    user_data = decode_user_token.first
    User.find_by(id: user_data['user_id'])
  end

  def decode_user_token
    begin
      JWT.decode(token, ENV['JWT_SECRET_TOKEN'], ENV['HASH_CODE'])
    rescue JWT::ExpiredSignature
    rescue JWT::VerificationError
    rescue JWT::DecodeError
    end

  end

  def payload
    {
      user_id: user.id,
      name: user.name,
      email: user.email,
      exp: Time.now.to_i + 150000
    }
  end

end