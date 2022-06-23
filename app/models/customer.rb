class Customer < ApplicationRecord
  has_many :accounts
  has_many :issued_payment_orders, class_name: 'PaymentOrder', foreign_key: :issuer_id
  has_many :received_payment_orders, class_name: 'PaymentOrder', foreign_key: :receiver_id

  has_secure_password

  def payment_orders
    PaymentOrder
      .where(id: issued_payment_orders)
      .or(PaymentOrder.where(id: received_payment_orders))
  end
end
