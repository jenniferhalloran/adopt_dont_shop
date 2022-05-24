require 'rails_helper'

describe 'admin shelter show page', type: :feature do
  let!(:shelter_1) {Shelter.create!(name: 'Aurora shelter', street_address: '15 Fluff Lane', state: 'CO', zip_code: 80152, city: 'Aurora', foster_program: false, rank: 9)}
  let!(:shelter_2) {Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)}

  it "shows the shelter's name and full address" do
    visit "/admin/shelters/#{shelter_1.id}"

    expect(page).to have_content('Aurora shelter')
    expect(page).to have_content('15 Fluff Lane')
    expect(page).to have_content('CO')
    expect(page).to have_content(80152)
    expect(page).to have_content('Aurora')
    expect(page).to_not have_content('RGV animal shelter')
  end

  it "displays the number of adoptable pets at the shelter" do
    Pet.create(adoptable: false, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter_1.id)
    Pet.create!(name: "Zucchini", breed: 'weenie dog', age: 7, adoptable: true, shelter_id: shelter_1.id)
    Pet.create!(name: "Tater Tot", breed: 'french bulldog', age: 5, adoptable: true, shelter_id: shelter_1.id)

    visit "/admin/shelters/#{shelter_1.id}"
    save_and_open_page
    expect(page).to have_content("Number of Adoptable Pets: 2")
  end

end
