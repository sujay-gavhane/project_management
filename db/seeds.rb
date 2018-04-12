# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Employee.create(
  email: 'test@projectmanagement.com', password: 'test1234',
  password_confirmation: 'test1234', first_name: "testfirstname",
  last_name: "testlastname"
)
employee = Employee.find_by(email: 'test@projectmanagement.com')
employee.remove_role :developer
employee.add_role :manager

