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

  describe 'shelter statistics' do
    before do
    @lucille = Pet.create(adoptable: false, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter_1.id)
    @zucchini = Pet.create!(name: "Zucchini", breed: 'weenie dog', age: 7, adoptable: true, shelter_id: shelter_1.id)
    @tot = Pet.create!(name: "Tater Tot", breed: 'french bulldog', age: 5, adoptable: true, shelter_id: shelter_1.id)
    @rufus = Pet.create!(name: "Rufus", breed: 'naked mole rat', age: 2, adoptable: true, shelter_id: shelter_1.id)
    end

    it "displays the number of adoptable pets at the shelter" do
      visit "/admin/shelters/#{shelter_1.id}"

      expect(page).to have_content("Number of Adoptable Pets: 3")
    end

    it "displays the average age of adoptable pets at the shelter" do
      visit "/admin/shelters/#{shelter_1.id}"

      expect(page).to have_content("Average Age of Adoptable Pets: 4.67")
    end

    it "displays the number of pets that have been adopted" do
      app_1 = Application.create!(name: 'Stephen', street_address: '3 Green St', city: 'Boulder', state: 'CO', zip_code: 80303)
      PetApplication.create!(pet: @lucille, application: app_1)
      app_2 = Application.create!(name: 'Zach', street_address: '3 Green St', city: 'Boulder', state: 'CO', zip_code: 80303)
      PetApplication.create!(pet: @tot, application: app_2)
      visit "/admin/shelters/#{shelter_1.id}"

      expect(page).to have_content("0 pets have been adopted from this shelter!")

      app_1.status = "Approved"
      app_1.save
      app_2.status = "Approved"
      app_2.save

      visit "/admin/shelters/#{shelter_1.id}"

      expect(page).to have_content("2 pets have been adopted from this shelter!")
    end

    it "shows pets that have pending applications and need action" do
      app_1 = Application.create!(name: 'Stephen', street_address: '3 Green St', city: 'Boulder', state: 'CO', zip_code: 80303)
      app_2 = Application.create!(name: 'Jack', street_address: '3 Green St', city: 'Boulder', state: 'CO', zip_code: 80303)
      pet_app = PetApplication.create!(pet: @tot, application: app_1)
      pet_app_2 = PetApplication.create!(pet: @tot, application: app_2)

      visit "/admin/shelters/#{shelter_1.id}"
      within "#action_required" do
        expect(page).to have_content("Tater Tot")
      end

      pet_app.update(application_status: "Rejected")
      pet_app_2.update(application_status: "Approved")
      visit "/admin/shelters/#{shelter_1.id}"

      within "#action_required" do
        expect(page).to_not have_content("Tater Tot")
      end
    end

    it "has links to approve or reject the pending application" do
      app_1 = Application.create!(name: 'Stephen', street_address: '3 Green St', city: 'Boulder', state: 'CO', zip_code: 80303)
      PetApplication.create!(pet: @tot, application: app_1)

      visit "/admin/shelters/#{shelter_1.id}"

      within "#action_required" do
        click_link("HERE")
      end

      expect(current_path).to eq("/admin/applications/#{app_1.id}")
    end
  end

end
