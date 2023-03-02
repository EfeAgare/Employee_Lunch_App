# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




[{department: "operations", name: "Efe"}, {department: "sales", name: "Ise"}, 
{department: "marketing", name: "Oshe"}, {department: "risk", name: "Maureen"}, 
{department: "management", name: "Grace"}, 
{department: "finance", name: "Dapo"}, {department: "HR", name: "Coza"}, 
{department: "development and data", name: "Debbie"}].each do |list|

  department = Department.create!(name: list[:department])
  Employee.create!(name: list[:name], department_id: department.id )
end

