FactoryBot.define do
  factory :account do
    iban { 'AT483200000012345864' }
    currency { 'EUR' }
  end
end
