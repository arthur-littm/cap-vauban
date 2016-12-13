# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'arthur.littmann@gmail.com', password: 'password1', password_confirmation: 'password1')
AdminUser.create!(email: 'francois@cap-vauban.com', password: 'password1', password_confirmation: 'password1')

Flat.create(title: "La Plage", description: "Appartement de charme, vue port Vauban, proche vieille ville, parking wifi clim")
Flat.create(title: "Le Port", description: "Appartement de charme, vue port Vauban, proche vieille ville, parking wifi clim")
