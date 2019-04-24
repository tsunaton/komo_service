FactoryBot.define do
  factory :funeral_hall do
    name {"TEST_NAME#{n}"}
    address {"テスト県テスト市テスト区"}
    nearest_station {"大宮駅"}
  end
end
