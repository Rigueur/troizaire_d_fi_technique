puts "Clearing the DB..."
Participation.destroy_all
Match.destroy_all
Player.destroy_all
Team.destroy_all
Tournament.destroy_all

Task.destroy_all
User.destroy_all
Project.destroy_all
puts "done"

puts "Creating the DB..."
puts "Creating some teams and some players..."
10.times do
  Team.create!(name: Faker::Team.name, city: Faker::Address.city)
  11.times do
    Player.create!(name: Faker::Name.name, team: Team.last, role: ["heal", "tank", "DPS"].sample)
  end
end
puts "Creating some tournaments..."
5.times do
  Tournament.create!
end


puts "Creating some users..."
5.times do
  User.create!(name: Faker::Name.name)
end
puts "Creating some projects..."
6.times do
  Project.create!(name: Faker::App.name)
end
puts "Creating some tasks..."
20.times do
  Task.create!(name: Faker::Lorem.sentence, project: Project.all.sample, user: User.all.sample)
end
