module AdminUsers
  class SessionsController < ::Devise::SessionsController
    layout 'active_admin_logged_out'
    helper ::ActiveAdmin::ViewHelpers
    before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(_resource)
      admin_root_path
    end

    def create
      result = AdminUsers::Authenticate.execute(
        email: sign_in_params[:email],
        password: sign_in_params[:password],
        otp_attempt: sign_in_params[:otp_attempt]
      )

      flash[:notice] = result.message
      super
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_in, keys: [:otp_attempt])
    end
  end
end