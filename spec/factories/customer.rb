FactoryBot.define do
  factory :customer do
    email { 'email@mail.com' }
    password { 'secret' }
    full_name { 'Customer 1' }

    trait :with_account do
      transient do
        account { build(:account) }
      end

      after(:create) do |customer, evaluator|
        create(:account, customer: customer)
      end
    end
  end
end
