FactoryBot.define do
  factory :shift do
    sequence(:scheduled_from) { |n| "Sun, 25 Dec 201#{n} 00:00:00 +0000" }
    sequence(:scheduled_to) { |n| "Sun, 25 Dec 201#{n} 12:00:00 +0000" }
  end
end
