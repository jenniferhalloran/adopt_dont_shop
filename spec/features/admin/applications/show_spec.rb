require 'rails_helper'

RSpec.describe do
  describe 'admin applications show page' do
    let!(:shelter) {Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)}
    let!(:app_1) {Application.create(name: 'Stephen', street_address: '3 Green St', city: 'Boulder', state: 'CO', zip_code: 80303)}
    let!(:app_2) {Application.create(name: 'Jenn', street_address: '2 Wildflower Lane', city: 'Aurora', state: 'CO', zip_code: 80010)}
    let!(:pet_1) {Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)}
    let!(:pet_2) {Pet.create!(name: "Zucchini", breed: 'weenie dog', age: 7, adoptable: true, shelter_id: shelter.id)}
    let!(:pet_application_1) {PetApplication.create!(pet_id: pet_2.id, application_id: app_1.id)}

    it 'can approve a pet on an application' do
      visit "/admin/applications/#{app_1.id}"

      within "#app-#{pet_application_1.id}" do
        click_button("Approve")
        expect(current_path).to eq("/admin/applications/#{app_1.id}")

        expect(page).to_not have_button("Approve")
        expect(page).to have_content("Approved")
      end
    end

    it 'can reject a pet on an application' do
      visit "/admin/applications/#{app_1.id}"

      within "#app-#{pet_application_1.id}" do
        click_button("Reject")
        expect(current_path).to eq("/admin/applications/#{app_1.id}")

        expect(page).to_not have_button("reject")
        expect(page).to have_content("Rejected")
      end
    end

    it 'changes the application status to approved if all pets for that application are approved' do
            visit "/admin/applications/#{app_1.id}"
            within "#app-#{pet_application_1.id}" do
              click_button("Approve")
              expect(current_path).to eq("/admin/applications/#{app_1.id}")

            end
            expect(page).to have_content("Application Status: Approved")
 
    end

    it 'changes the application status to rejected if any pets for that application are rejected' do
           pet_application_2 = PetApplication.create!(pet_id: pet_1.id, application_id: app_1.id)

            visit "/admin/applications/#{app_1.id}"
            within "#app-#{pet_application_1.id}" do
              click_button("Reject")
              expect(current_path).to eq("/admin/applications/#{app_1.id}")

            end
            within "#app-#{pet_application_2.id}" do
              click_button("Approve")
              expect(current_path).to eq("/admin/applications/#{app_1.id}")
            end
            expect(page).to have_content("Application Status: Rejected")
 
    end
  end
end