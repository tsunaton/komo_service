FactoryBot.define do
  factory :client do
    sequence(:name) { |n| "TEST_NAME#{n}" }
    sequence(:address) { |n| "テスト県テスト市#{n}区" }
    dispatching_fee_per_hour { 2000 }
  end
end
