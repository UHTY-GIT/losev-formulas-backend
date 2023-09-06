module PodcastFlow
  class RemoveFromFavorite
    def initialize(current_user, podcast_id)
      @current_user = current_user
      @podcast_id = podcast_id
    end

    def call
      remove_from_favorite_podcasts if favorite_podcast.active
    end

    private

    def remove_from_favorite_podcasts
      favorite_podcast.update!(active: false)
    end

    def favorite_podcast
      current_user.favorite_podcasts.find_by(podcast_id: podcast_id)
    end

    attr_reader :current_user, :podcast_id
  end
end