class Order < ApplicationRecord

  acts_as_api

  enum status: %i[process success unsuccess]

  enum payment_method: %i[portmone easy_pay liq_pay]

  belongs_to :user
  belongs_to :podcast

  api_accessible :simple do |t|
    t.add :uuid, as: :id
    t.add :podcast_id
    t.add :status
    t.add :payment_method
    t.add :amount
  end

end
