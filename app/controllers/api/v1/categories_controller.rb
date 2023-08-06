module Api
  module V1
    class CategoriesController < Api::V1::ApiController

      swagger_controller :api_v1_categories, "Categories", resource_path: "Categories"

      swagger_api :index do
        summary 'Get all categories'
        response :ok, 'Success'
      end

      def index
        categories = Category.all.as_api_response(:list)
        render_success categories
      end

    end
  end
end