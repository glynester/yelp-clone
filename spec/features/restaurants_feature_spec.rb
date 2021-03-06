require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario "should prompt to add a restaurant" do
      visit "/restaurants"
      expect(page).to have_content("No restaurants yet")
      expect(page).to have_link("Add a restaurant")
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name:"KFC", description: "Finger lickin'")
    end
    scenario 'display restaurants' do
      visit "/restaurants"
      expect(page).to have_content("KFC")
      # expect(page).to have_content("Finger lickin'")
      expect(page).not_to have_content("No restaurants yet")
    end
  end

  context "adding a restaurant" do
    scenario "prompts user to complete a form and then displays the new restaurant" do
      visit "/restaurants"
      click_link("Add a restaurant")
      fill_in("Name", with: "KFC")
      # fill_in("rating", with: "3")
      click_button("Create Restaurant")
      # expect(page).to have_content("Restaurant successfully added")
      expect(page).to have_content("KFC")
      expect(current_path).to eq("/restaurants")
    end

    context "an invalid restaurant" do
      scenario "does not let you submit a name that is too short" do
        visit "/restaurants"
        click_link "Add a restaurant"
        fill_in "Name", with: "kf"
        click_button "Create Restaurant"
        expect(page).not_to have_css "h2", text: "kf"
        expect(page).to have_content "error"
      end
    end

  end

  context "viewing restaurants" do
    let!(:kfc){Restaurant.create(name: "KFC")}
    scenario "Lets a user view a restaurant" do
      visit "/restaurants"
      click_link("KFC")
      expect(page).to have_content("KFC")
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do

    before { Restaurant.create name: 'KFC', description: 'Deep fried goodness' }

    scenario 'let a user edit a restaurant' do
     visit '/restaurants'
     click_link 'Edit KFC'
     fill_in 'Name', with: 'Kentucky Fried Chicken'
     fill_in 'Description', with: 'Deep fried goodness'
     click_button 'Update Restaurant'
     expect(page).to have_content 'Kentucky Fried Chicken'
    #  expect(page).to have_content 'Deep fried goodness'
     expect(current_path).to eq '/restaurants'
    end
  end
  context "deleting restaurants" do
    before {Restaurant.create name:"KFC", description: "Deep fried goodness"}
    scenario "removes a restaurant when a user clicks a delete link" do
      visit "/restaurants"
      click_link "Delete KFC"
      expect(page).not_to have_content "KFC"
      expect(page).to have_content "Restaurant successfully deleted"
    end
  end


end
