module PodcastFlow
  class AddToFavorite
    def initialize(current_user, podcast_id)
      @current_user = current_user
      @podcast_id = podcast_id
    end

    def call
      add_to_favorite_list
    end

    private

    attr_reader :current_user, :podcast_id

    def add_to_favorite_list
      return if user_has_podcast?
      FavoritePodcast.create!(user_id: current_user.id, podcast_id: podcast_id)
      true
    end

    def user_has_podcast?
      user_podcast_ids.include?(podcast_id.to_i)
    end

    def user_podcast_ids
      current_user.favorite_podcasts.pluck(:podcast_id)
    end
  end
end