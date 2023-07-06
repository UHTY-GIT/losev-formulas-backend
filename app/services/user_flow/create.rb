module UserFlow
  class Create

    attr_reader :user, :token
    def initialize(params)
      @params = params
    end

    def call
      ActiveRecord::Base.transaction do
        create_user!
        create_user_token!
      end
    end

    private

    attr_reader :params

    def create_user!
      @user = User.create!(user_params)
    end

    def create_user_token!
      @token = JwtService.new({user: @user}).generate_token
    end

    def user_params
      params.permit(:name, :email, :password, :avatar)
    end

  end
end