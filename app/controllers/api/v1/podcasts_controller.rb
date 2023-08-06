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
        podcasts= PodcastQuery.new(Podcast.all, params).call

        render_success podcasts.as_api_response(:list)
      end

    end
  end
end