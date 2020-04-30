# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

5.times do # creation de 50 villes 
	city = City.create(name: Faker::Address.city)
end

60.times do # creation de 60 chiens
	dog = Dog.create(name: Faker::FunnyName.name,
						breed: Faker::StarWars.specie,
						city_id: rand((City.first.id)..(City.last.id)))
end

20.times do # creation de 20 promeneurs
	dog = Dogsitter.create(first_name: Faker::Name.first_name, 
							last_name: Faker::Name.last_name, 
							city_id: rand((City.first.id)..(City.last.id)))
end

90.times do # creation de promenades, dates possibles réservables jusque dans 2 mois durant la journée,
	stroll = Stroll.new(date: Faker::Time.forward(60, :day),
							place: Faker::Space.planet,
							city_id: rand((City.first.id)..(City.last.id)))
	stroll.dogsitter_id = Dogsitter.where(city_id: stroll.city_id).pluck(:id).sample
	# choisi un promeneur qui habite la meme ville que la promenade
	stroll.save
	# enregistre la nouvelle promenade
end

90.times do |id| # ajoute successivement dpour chaque promenade 3 chiens de la meme ville
	dogs_strolls = Stroll.find(id+1).dogs << [Dog.where(city_id: Stroll.find(id+1).city_id).sample,
												Dog.where(city_id: Stroll.find(id+1).city_id).sample,
												Dog.where(city_id: Stroll.find(id+1).city_id).sample]
	id += 1
end