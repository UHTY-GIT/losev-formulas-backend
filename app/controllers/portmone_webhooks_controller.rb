class PortmoneWebhooksController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:payment_success]

  before_action :find_order!

  def payment_success
    PodcastFlow::CompleteOrderPodcast.new(@order).call

    redirect_to ENV['SUCCESS_PORTMONE_CLIENT_URL']
  end

  private

  def find_order!
    @order = Order.find_by_uuid(params["SHOPORDERNUMBER"])

    render json: { message: "invalid token" }, status: 422 unless @order
  end

end
