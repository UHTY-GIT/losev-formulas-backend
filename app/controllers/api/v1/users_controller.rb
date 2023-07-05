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


        return render_success(@user.as_api_response(:simple)
                              .merge!(token: service.token)) if @user

        render_errors(@user)
      end

    end
  end
end