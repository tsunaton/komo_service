FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "TEST_NAME#{n}"}
    sequence(:email) { |n| "TEST#{n}@example.com"}
    sequence(:address) { |n| "テスト県テスト市テスト区#{n}番地"}
    sequence(:nearest_station) { |n| "#{n}本木駅"}
    sequence(:pay_per_hour) { |n| 1000 }
    sequence(:password) { |n| "#{n}12345" }
  end
end
