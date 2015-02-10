# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create([
  {email: 'test@test.com', password: 'abcd1234', password_confirmation: 'abcd1234'},
  {email: 'test2@test.com', password: 'abcd1234', password_confirmation: 'abcd1234'},
  {email: 'test3@test.com', password: 'abcd1234', password_confirmation: 'abcd1234'},
  {email: 'test4@test.com', password: 'abcd1234', password_confirmation: 'abcd1234'}
])

u = User.last
u.teams << Team.new(notes: 'Team 1')
u.teams << Team.new(notes: 'Team 2')
u.teams << Team.new(notes: 'Team 3')
a = 10
u.teams.each do |team|
  team.create_or_update_result({notes: 'Result for team 1', score: a})
  a+=5
end
