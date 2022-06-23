class Customer < ApplicationRecord
  has_many :accounts
  has_many :issued_payment_orders, class_name: 'PaymentOrder', foreign_key: :issuer_id
  has_many :received_payment_orders, class_name: 'PaymentOrder', foreign_key: :receiver_id

  has_secure_password
end
