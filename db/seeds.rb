# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Workをいっぱい作る
6.times do |i|
  unless i == 0
    start_time = "2019-03-1#{i} 0#{i}:00:00"
    end_time = "2019-03-1#{i} 1#{i}:00:00"
    Work.create(:id => i, :start_time => start_time, :end_time => end_time, :number_of_people => i, :place_id => i, :client_id => i)
  end
end

#Machingをいっぱい作る
10.times do |i|
  unless i == 0
    Maching.create(:id => i, :shift_id => rand(10..13), :work_id => rand(1..5))
  end
end
