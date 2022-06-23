class PaymentOrder < ApplicationRecord
  STATUSES = %w[pending processing completed failed]

  belongs_to :issuer, class_name: 'Customer'
  belongs_to :receiver, class_name: 'Customer'
  has_one :payment

  enum status: STATUSES.zip(STATUSES).to_h
end
