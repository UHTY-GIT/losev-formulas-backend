module ResponseHelper

  extend ActiveSupport::Concern

  def unprocessable_entity(exception)
    if exception&.record&.invalid?
      render_errors(exception.record)
    end
  end

  def render_errors(record)
    validation_error(record.errors.messages, record.errors.full_messages.join(', '))
  end

  def validation_error(errors, message = I18n.t('errors.validation'))
    render json: {
      errors: errors,
      message: message
    }, status: 422
  end

  def render_success(data)
    render json: {
      data: data
    }
  end

  def current_user_must_be
    if current_user.nil?
      render_auth_error
    else
      true
    end

  end

  def current_user
    @current_user = JwtService.new({token: get_auth_token}).get_current_user
  end

  def get_auth_token
    request.headers['authtoken']
  end

  def render_auth_error
    render json: {
      error: {
        message: I18n.t('errors.user_must_be')
      }
    }
  end
end
