require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario "should prompt to add a restaurant" do
      visit "/restaurants"
      expect(page).to have_content("No restaurants to display")
      expect(page).to have_link("Add a restaurant")
    end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name:"KFC")
    end
    scenario 'display restaurants' do
      expect(page).to have_content("KFC")
      expect(page).not_to have_content("No restaurants to display")
    end

  end

  end
end