FactoryBot.define do
  factory :funeral do
    sequence(:start_time) { |n| "Sun, 25 Dec 201#{n} 00:00:00 +0000"}
    sequence(:number_of_people) { |n| 2 }
  end
end
