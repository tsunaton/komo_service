FactoryBot.define do
  factory :shift do
    scheduled_from { "Sun, 25 Dec 201 00:00:00 +0000" }
    scheduled_to { "Sun, 25 Dec 201 12:00:00 +0000" }
  end
end
