module RatingFlow
  class SetRating
    def initialize(user, params)
      @user, @params = user, params
    end

    def call
      return unless user_can_set_rate_for_podcast?

      create_rating
      UpdateRatingForPodcast.new(params[:podcast_id]).call
    end

    private

    attr_reader :user, :params, :rating_params

    def create_rating
      Rating.create!(rating_params)
    end

    def rating_params
      @rating_params ||= {
        user_id: user.id,
        podcast_id: params[:podcast_id],
        rating_value: params[:rating_value]
      }
    end

    def user_can_set_rate_for_podcast?
      true if Rating.where(user_id: user.id, podcast_id: params[:podcast_id]).empty?
    end
  end
end