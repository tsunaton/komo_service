FactoryBot.define do
  factory :client do
    sequence(:funeral_id) { |n| "#{n}"}
    sequence(:name) { |n| "TEST_NAME#{n}"}
    sequence(:address) { |n| "テスト県テスト市テスト区#{n}番地"}
    sequence(:dispatching_fee_per_hour) { |n| 2000 }
  end
end
