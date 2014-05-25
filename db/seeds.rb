# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

30.times do |i|
  Node.create!(name: Faker::Company.name())
end

400.times do |i|
  p = Path.where(begin_node_id: Node.all.sample.id, end_node_id: Node.all.sample.id).first_or_create!
  traversals = p.total_traversals + 1
  p.update(total_traversals: traversals)
end
