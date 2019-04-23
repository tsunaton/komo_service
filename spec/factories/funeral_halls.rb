FactoryBot.define do
  factory :funeral_hall do
    sequence(:name) { |n| "TEST_NAME#{n}"}
    sequence(:address) { |n| "テスト県テスト市テスト区#{n}番地" }
    sequence(:nearest_station) { |n| "#{n}ノ宮駅" }
  end
end
