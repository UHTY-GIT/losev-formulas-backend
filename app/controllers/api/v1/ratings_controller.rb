module Api
  module V1
    class RatingsController < Api::V1::ApiController
      swagger_controller :api_v1_ratings, 'Rating', resource_path: 'Rating'

      swagger_api :set_rating do
        summary 'Set rating for podcasts'
        param :header, :authtoken, :string, :required, 'User authtoken'
        param :form, :podcast_id, :integer, :required, 'Podcast identifier'
        param :form, :rating_value, :integer, :required, 'Rating value'
        response :ok, 'Success'
      end

      def set_rating
        current_user_must_be && return

        service = RatingFlow::SetRating.new(current_user, params).call
        render_success service
      end
    end
  end
end