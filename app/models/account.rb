class Account < ApplicationRecord
  belongs_to :customer
  has_many :source_payments, class_name: 'Payment', foreign_key: :source_id
  has_many :target_payments, class_name: 'Payment', foreign_key: :target_id
end
