module UserFlow
  class ChangePassword
    attr_reader :error_message

    def initialize(current_user, params)
      @current_user = current_user
      @old_password = params[:old_password]
      @new_password = params[:new_password]
      @error_message = nil
    end

    def call
      return @error_message = I18n.t('errors.current_password_is_incorect') unless check_old_passwd
      change_password
    end

    private
    attr_reader :current_user, :new_password, :old_password

    def check_old_passwd
      current_user.authenticate(@old_password)
    end

    def change_password
      return if @new_password.nil?
      current_user.update!(password: @new_password)
    end
  end
end

