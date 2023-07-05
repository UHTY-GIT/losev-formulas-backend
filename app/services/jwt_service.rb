class JwtService
  def initialize(user)
    @user = user
  end

  def generate_token
    return unless user
    create_user_token
  end


  private

  attr_reader :user, :payload

  def create_user_token
    JWT.encode(payload, ENV['JWT_SECRET_TOKEN'], ENV['HASH_CODE'])
  end

  def payload
    {
      user_id: user.id,
      name: user.name,
      email: user.email,
      exp: Time.now.to_i + 15000
    }
  end

end