# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



=begin
University.create!([{
    university_id: "8",
		name: "North Carolina State University"
                    }])

University.create!([{
												university_id: "9",
												name: "University of North Carolina at Charlotte"
										}])

University.create!([{
												university_id: "10",
												name: "Duke University"
										}])

University.create!([{
												university_id: "11",
												name: "University of North Carolina at Chapel Hill"
										}])

University.create!([{
												university_id: "12",
												name: "East Carolina University"
										}])
=end
Admin.create!([{
    										name: "admin",
                        email: "admin@lib.com",
                        password: "$2a$10$pO76oucPrpONo8zL7t9v8eyaCCbEs9/C7Kljk9aPWzxBYj7ERvWNS"
               }])
