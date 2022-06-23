class Payment < ApplicationRecord
  belongs_to :order, class_name: 'PaymentOrder'
  belongs_to :source, class_name: 'Account'
  belongs_to :target, class_name: 'Account'
end
