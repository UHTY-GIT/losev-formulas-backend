module PodcastFlow
  class CompleteOrderPodcast
    def initialize(order)
      @order = order
    end

    def call
      change_order_status!
      purchase_podcast_for_user!
    end

    attr_reader :order

    def purchase_podcast_for_user!
      podcast = order.podcast
      user = order.user

      UserPodcast.create!(user: user, podcast: podcast)
    end

    def change_order_status!
      order.update(status: :success)
      order.save
    end
  end
end