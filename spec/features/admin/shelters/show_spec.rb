# Admin Shelters Show Page
#
# As a visitor
# When I visit an admin shelter show page
# Then I see that shelter's name and full address
require 'rails_helper'

describe 'admin shelter show page', type: :feature do
  let!(:shelter_1) {Shelter.create!(name: 'Aurora shelter', street_address: '15 Fluff Lane', state: 'CO', zip_code: 80152, city: 'Aurora', foster_program: false, rank: 9)}
  let!(:shelter_2) {Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)}
  # let!(:shelter_3) {Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)}

  it "shows the shelter's name and full address" do
    visit "/admin/shelters/#{shelter_1.id}"

    expect(page).to have_content('Aurora shelter')
    expect(page).to have_content('15 Fluff Lane')
    expect(page).to have_content('CO')
    expect(page).to have_content(80152)
    expect(page).to have_content('Aurora')
    expect(page).to_not have_content('RGV animal shelter')
  end

end
