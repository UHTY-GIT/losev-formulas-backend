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

        return render_success @user.as_api_response(:simple).merge!(token: service.token) if @user

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
      end

    end
  end
end