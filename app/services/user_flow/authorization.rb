module UserFlow
  class Authorization

    attr_reader :token, :user, :error_message

    def initialize(params)
      @params = params
      @error_message = nil
    end

    def call
      ActiveRecord::Base.transaction do
        find_user
        create_user_token!
      end
    end

    private

    attr_reader :params


    def create_user_token!
      return @error_message = I18n.t('errors.password_or_email') unless user_can_be_auth?
      @token = JwtService.new({
                                user: @user
                              }).generate_token
    end

    def user_can_be_auth?
      @user&.authenticate(params[:password])
    end

    def find_user
      @user = User.find_by_email(params[:email])
    end
  end
end
