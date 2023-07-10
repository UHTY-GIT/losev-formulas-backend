module Api
  module V1
    class UsersController < Api::V1::ApiController

      swagger_controller :api_v1_users, 'Users Auth', resource_path: 'Users Auth'

      swagger_api :sign_up do
        summary 'User registration'
        param :form, :name, :string, :required, 'User name'
        param :form, :email, :string, :required, 'User email'
        param :form, :avatar, :file, :optional, 'User avatar'
        param :form, :password, :string, :required, 'User password'
        response :ok, 'Success'
      end

      def sign_up
        service = UserFlow::Create.new(params)
        service.call
        @user = service.user

        return render_success @user.as_api_response(:simple).merge!(token: $redis.get("user_#{@user.id}")) if @user

        render_errors(@user)
      end

      swagger_api :sign_in do
        summary 'User authentication'
        param :form, :email, :string, :required, 'User email'
        param :form, :password, :string, :required, 'User password'
        response :ok, 'Success'
      end

      def sign_in
        service = UserFlow::Authorization.new(params)
        service.call

        return render_success service.user.as_api_response(:simple).merge!(token: service.token) unless service.error_message

        validation_error(service.error_message)
      end

      swagger_api :profile_update do
        summary 'Update user profile'
        param :header, :authtoken, :string, :required, 'User auth token'
        param :form, :name, :string, :required, 'User name'
        param :form, :email, :string, :required, 'User email'
        param :form, :avatar, :file, :optional, 'User avatar'
        response :ok, 'Success'
      end

      def profile_update
        current_user_must_be && return

        service = UserFlow::Update.new(params, current_user)
        service.call

        render_success current_user.as_api_response(:simple)
      end

      swagger_api :logout do
        summary 'Destroy user session'
        param :header, :authtoken, :string, :required, 'User auth token'
        response :ok, 'Success'
      end

      def logout
        current_user_must_be && return

        service = JwtService.new({
                                   user: current_user,
                                   destroy: true
                                 })
        service.logout_current_user

        render_success true
      end

      swagger_api :profile do
        summary 'User profile'
        param :header, :authtoken, :string, :required, 'User authtoken'
        response :ok, 'Success'
      end

      def profile
        current_user_must_be && return

        render_success current_user.as_api_response(:index)
      end

      swagger_api :change_password do
        summary 'Change customer password'
        param :header, :authtoken, :string, :required, 'User authtoken'
        param :form, :old_password, :string, :required, 'User old password'
        param :form, :new_password, :string, :required, 'User new password'
        response :ok, 'Success'
      end

      def change_password
        current_user_must_be && return

        service = UserFlow::ChangePassword.new(current_user, params)
        service.call
        return validation_error(service.error_message) if service.error_message

        render_success true
      end

    end
  end
end