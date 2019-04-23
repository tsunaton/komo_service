FactoryBot.define do
  factory :working_hour do
    sequence(:start_time) { |n| "Sun, 25 Dec 201#{n} 00:00:00 +0000" }
  end
end
