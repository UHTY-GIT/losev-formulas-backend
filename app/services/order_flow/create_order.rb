module OrderFlow
  class CreateOrder

    attr_reader :order, :order_link

    def initialize(current_user, params)
      @current_user = current_user
      @params = params
    end

    def call
      create_order!
      @order_link = Portmone::Connector.create_link_for_pay!(portmone_data) if @order
    end

    private

    attr_reader :current_user, :params, :podcast, :order_uuid

    def create_order!
      @order = Order.create(order_params)
    end

    def portmone_data
      {
        payee_id: ENV['PAYEE_ID'],
        amount: podcast.price,
        description: podcast.title,
        order_id: order.uuid,
        email: current_user.email,
        success_url: ENV['SUCCESS_PORTMONE_URL']
      }
    end


    def order_params
      {
        uuid: order_uuid,
        user_id: current_user.id,
        podcast_id: podcast.id,
        amount: podcast.price,
        payment_method: params[:payment_method]
      }
    end

    def order_uuid
      @order_uuid = UUID.generate
    end
    def podcast
      @podcast = Podcast.find_by(id: params[:podcast_id])
    end
  end
end