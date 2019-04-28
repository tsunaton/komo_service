FactoryBot.define do
  factory :working_hour do
    start_time { "Sun, 25 Dec 2019 00:00:00 +0000" }
    user
    funeral
  end
end
