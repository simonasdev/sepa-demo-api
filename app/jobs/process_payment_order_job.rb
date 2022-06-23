class ProcessPaymentOrderJob < ApplicationJob
  queue_as :default

  def perform(*id)
    payment_order = PaymentOrder.find(id)

    # perform direct debit initiation

    payment_order.processing!
  end
end

