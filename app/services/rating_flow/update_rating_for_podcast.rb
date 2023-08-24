module RatingFlow
  class UpdateRatingForPodcast
    def initialize(podcast_id, rating_value)
      @podcast_id = podcast_id
      @rating_value = rating_value
    end

    def call
      update_podcast_rating
    end

    private

    attr_reader :podcast_id, :rating_value, :podcast


    def update_podcast_rating
      rating = podcast_ratings.size.zero? ? rating_value : podcast_ratings.sum/podcast_ratings.size
      podcast.update!(rating: rating)
    end

    def podcast_ratings
      Rating.where(podcast_id: podcast_id).pluck(:rating_value)
    end

    def podcast
      @podcast ||= Podcast.find_by(id: podcast_id)
    end
  end
end