# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

150.times do |i|
  Node.create!(name: Faker::Name.name())
end

10000.times do |i|
  p = Path.find_or_create_by(begin_node_id: Node.all.sample.id, end_node_id: Node.all.sample.id)
  p.total_traversals = p.total_traversals + 1
  p.save!
end
