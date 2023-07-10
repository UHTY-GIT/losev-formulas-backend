class JwtService

  def initialize(data)
    @user = data[:user]
    @token = data[:token]
    @destroy = data[:destroy]
  end

  def generate_token
    return if user.nil?

    create_user_token
    add_token_to_redis
  end

  def get_current_user
    return unless token
    current_user
  end

  def logout_current_user
    return unless destroy
    destroy_user_token!
  end


  private

  attr_reader :data, :user, :token, :payload, :destroy

  def add_token_to_redis
    user.update!(redis_key: Passgen.generate(length: 20))

    $redis.set(user.redis_key, @token)
    $redis.expire(user.redis_key, ENV['EXPIRE_TOKEN'].to_i)

    @token
  end

  def create_user_token
    @token = JWT.encode(payload, ENV['JWT_SECRET_TOKEN'], ENV['HASH_CODE'])
  end

  def destroy_user_token!
    $redis.del(user.redis_key)
  end

  def current_user
    return unless decode_user_token

    user_data = decode_user_token.first
    user = User.find_by(id: user_data['user_id'])
    token = $redis.get(user.redis_key)

    return unless token

    user
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
      exp: Time.now.to_i + ENV['EXPIRE_TOKEN'].to_i
    }
  end
end