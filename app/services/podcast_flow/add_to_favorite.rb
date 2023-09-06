module PodcastFlow
  class AddToFavorite
    def initialize(current_user, podcast_id, add_podcast)
      @current_user = current_user
      @podcast_id = podcast_id
      @add_podcast = add_podcast
    end

    def call
      add_to_favorite_list
    end

    private

    attr_reader :current_user, :podcast_id, :add_podcast, :favorite_podcast

    def add_to_favorite_list
      return PodcastFlow::RemoveFromFavorite.new(current_user, podcast_id).call if add_podcast.eql?("false")

      return create_favorite_podcast if is_new_podcast?

      favorite_podcast.update(active: true) if is_old_podcast?
    end

    def create_favorite_podcast
      FavoritePodcast.create!(user_id: current_user.id,
                              podcast_id: podcast_id,
                              active: true)
    end

    def is_new_podcast?
      !favorite_podcast
    end

    def is_old_podcast?
      favorite_podcast && favorite_podcast.active.eql?(false)
    end

    def favorite_podcast
      @favorite_podcast ||= current_user.favorite_podcasts.find_by(podcast_id: podcast_id)
    end
  end
end