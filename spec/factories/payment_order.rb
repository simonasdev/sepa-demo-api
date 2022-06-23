FactoryBot.define do
  factory :payment_order do
    status { :pending }
    amount { 10000 }
  end
end
