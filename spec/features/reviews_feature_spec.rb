require 'rails_helper'

feature 'reviewing' do

  scenario 'allows users to leave a review using a form' do
    sign_up_and_sign_in
    create_restaurant

    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  #This test will fail when the review button is hidden for restaurant you have already reviewed
  scenario "does not allow a user to leave more than one review for a restaurant" do
    sign_up_and_sign_in
    create_restaurant
    leave_review(restaurant: "KFC", thoughts: "so so", rating: 3)
    leave_review(restaurant: "KFC", thoughts: "I love it", rating: 4)
    expect(page).to have_content("This restaurant has already been reviewed by you")
    expect(page).not_to have_content("I love it")
  end

end
