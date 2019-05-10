# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@t = Time.now

@funerals =[
%W(#{@t.prev_week} 田中 1 1 2),
%W(#{@t.prev_week + 1.days} 朝倉 1 1 2),
%W(#{@t.yesterday} 吉田 2 2 3),
%W(#{@t.yesterday + 1.days} 真壁 2 2 3),
%W(#{@t} 臼倉 3 3 4),
%W(#{@t + 2.days} 浅田 2 4 3),
%W(#{@t.next_week} 松岡 5 5 1)]

@funerals.each do |start_time, family_name, number_of_people, client_id, funeral_hall_id|
  Funeral.create(start_time: start_time, family_name: family_name, number_of_people: number_of_people.to_i, client_id: client_id.to_i, funeral_hall_id: funeral_hall_id.to_i)
end

@works =[
%W(2 19 #{@t.prev_week} #{@t.prev_week + 3.hours} 3),
%W(3 19 #{@t.prev_week} #{@t.prev_week + 3.hours} 3),
%W(2 20 #{@t.prev_week + 1.days} #{@t.prev_week + 1.days + 4.hours} 3),
%W(3 21 #{@t.yesterday} #{@t.yesterday + 5.hours} 3),
%W(3 22 #{@t.yesterday + 1.days} #{@t.yesterday + 1.days + 6.hours} 3),
%W(2 23 #{@t} nil 1),
%W(2 24 #{@t + 2.days} nil 1),
%W(2 25 #{@t.next_week} nil 0),
%W(3 25 #{@t.next_week} nil 0)
]

@works.each do |user_id, funeral_id, start_time, end_time, status|
  WorkingHour.create(user_id: user_id.to_i, funeral_id: funeral_id.to_i, start_time: start_time, end_time: end_time, status: status.to_i)
end
