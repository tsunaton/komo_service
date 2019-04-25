FactoryBot.define do
  factory :user do
    name { "TEST_NAME"}
    sequence(:email) { |n| "TEST#{n}@example.com" }
    address { "テスト県テスト市" }
    nearest_station { "浦和駅" }
    pay_per_hour { 1000 }
    user_type { 1 }
    password { "123abc" }
  end
end
