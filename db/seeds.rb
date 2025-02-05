# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
PetApplication.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all

app_1 = Application.create!(name: 'Stephen', street_address: '3 Green St', city: 'Boulder', state: 'CO', zip_code: 80303)
app_2 = Application.create!(name: 'Jenn', street_address: '2 Wildflower Lane', city: 'Aurora', state: 'CO', zip_code: 80010)


shelter_1 = Shelter.create!(name: 'Aurora shelter', street_address: '15 Fluff Lane', state: 'CO', zip_code: 80152, city: 'Aurora', foster_program: false, rank: 9)
shelter_2 = Shelter.create!(name: 'RGV animal shelter', street_address: '2 Armadillo Street', city: 'Harlingen', state: 'TX', zip_code: 95647, foster_program: false, rank: 5)
shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', street_address: '14 Dapper Avenue', city: 'Denver', state: 'CO', zip_code: 80152, foster_program: true, rank: 10)

pet_1 = Pet.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true, shelter_id: shelter_1.id)
pet_2 = Pet.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true, shelter_id: shelter_1.id)
pet_3 = Pet.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true, shelter_id: shelter_2.id)
pet_7 = Pet.create!(name: "Bella", breed: 'dachshund', age: 4, adoptable:true, shelter_id: shelter_2.id)
pet_4 = Pet.create!(name: "Zucchini", breed: 'weenie dog', age: 7, adoptable: true, shelter_id: shelter_3.id)
pet_5 = Pet.create!(name: "Bonnie", breed: 'pug', age: 2, adoptable: true, shelter_id: shelter_3.id)
pet_6 = Pet.create!(name: "Tater Tot", breed: 'french bulldog', age: 5, adoptable: true, shelter_id: shelter_3.id)
