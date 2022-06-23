class PaymentOrder < ApplicationRecord
  STATUSES = %w[draft pending completed failed]

  belongs_to :issuer
  belongs_to :receiver
  has_one :payment

  enum status: STATUSES.zip(STATUSES).to_h
end
