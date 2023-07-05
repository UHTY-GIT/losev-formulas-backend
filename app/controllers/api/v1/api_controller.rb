module Api
  module V1
    class ApiController < ActionController::API
      include Swagger::Docs::Methods

      def render_success(data)
        render json: {
          data: data
        }
      end

      def validation_error(errors, message = I18n.t('errors.validation'))
        render('api/v1/errors/_validations', locals: { errors: errors, message: message }, status: 422)
      end

      def render_errors(record)
        validation_error(record.errors.messages, record.errors.full_messages.join(', '))
      end

    end
  end
end
