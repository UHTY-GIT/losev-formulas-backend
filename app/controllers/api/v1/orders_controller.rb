module Api
  module V1
    class OrdersController < Api::V1::ApiController

      swagger_controller :api_v1_orders, 'Orders', resource_path: 'Orders'

      swagger_api :create do
        summary 'Create order'
        param :header, :authtoken, :string, :required, 'User authtoken'
        param :form, :podcast_id, :string, :required, 'Podcast identifier'
        param :form, :payment_method, :string, :required, 'Paymnet method'
        response :ok, 'Success'
      end

      def create
        current_user_must_be && return

        service = OrderFlow::CreateOrder.new(current_user, params)
        service.call

        order = service.order
        order_link = service.order_link

        render_success order.as_api_response(:simple).merge!({ order_link: order_link })
      end

    end
  end
end