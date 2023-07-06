module Api
  module V1
    class ApiController < ActionController::API
      include Swagger::Docs::Methods
      include ResponseHelper

      rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

    end
  end
end
