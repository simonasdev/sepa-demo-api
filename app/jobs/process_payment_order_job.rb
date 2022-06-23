class ProcessPaymentOrderJob < ApplicationJob
  queue_as :default

  def perform(*id)
    payment_order = PaymentOrder.find(id)

    payment_order.processing!

    # execute some kind of SEPA integration
  end
end

