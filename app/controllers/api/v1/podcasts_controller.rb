module Api
  module V1
    class PodcastsController < Api::V1::ApiController

      swagger_controller :api_v1_podcasts, "Podcasts", resource_path: "Podcasts"

      swagger_api :index do
        summary "All podcasts"
        param :query, :category_type, :string, :optional, "Category type free | paid"
        param :query, :category_name, :string, :optional, "Category name"
        param :query, :sort_by, :string, :optional, 'Sort by name, created, price'
        param :query, :search, :string, :optional, 'Search by title, desc'
        response :ok, 'Success'
      end

      def index
        podcasts= PodcastQuery.new(Podcast.includes(:categories).all, params).call

        render_success podcasts.as_api_response(:list)
      end

      swagger_api :add_to_favorite do
        summary 'Add podcast to favorite list'
        param :header, :authtoken, :string, :required, 'User authtoken'
        param :form, :podcast_id, :integer, :required, 'Podcast identifier'
        param :form, :add_podcast, :boolean, :required, 'True if add, False if remove'
        response :ok, 'Success'
      end

      def add_to_favorite
        current_user_must_be && return

        service = PodcastFlow::AddToFavorite.new(current_user, params[:podcast_id], params[:add_podcast]).call
        render_success service
      end

      swagger_api :favorite do
        summary 'Favorite podcast list'
        param :header, :authtoken, :string, :required, 'User authtoken'
        response :ok, 'Success'
      end

      def favorite
        current_user_must_be && return
        podcasts = Podcast
                     .joins(:favorite_podcasts)
                     .where(favorite_podcasts: { user_id: current_user.id, active: true})
                     .distinct

        render_success podcasts.as_api_response(:list)
      end

      swagger_api :user_podcasts do
        summary "User's podcasts podcast list"
        param :header, :authtoken, :string, :required, 'User authtoken'
        response :ok, 'Success'
      end

      def user_podcasts
        current_user_must_be && return
        podcasts = Podcast
                     .joins(:user_podcasts)
                     .where(user_podcasts: { user_id: current_user.id})
                     .distinct

        render_success podcasts.as_api_response(:list)
      end

      swagger_api :top do
        summary "Top podcasts"
        response :ok, 'Success'
      end

      def top
        podcasts = Podcast.in_top
        render_success podcasts.as_api_response(:simple)
      end

      swagger_api :recommendation do
        summary "Recommend podcasts"
        response :ok, 'Success'
      end

      def recommendation
        podcasts = Podcast.recommended
        render_success podcasts.as_api_response(:simple)
      end
    end
  end
end