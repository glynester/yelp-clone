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

  # ID's are hardcoded
  # Not yet working!
  # scenario "cannot add a review if reviewed already" do
  #   user = User.create(email: 'joe@joe.com', password: 'joejoe', password_confirmation: 'joejoe')
  #   @restaurant = Restaurant.create(name: "Cafe del Mar", description: "On the beach al fresco", user_id: user.id)
  #   p @restaurant
  #   visit "/restaurants"
  #   leave_review(restaurant: "Cafe del Mar", thoughts: "so so", rating: 3)
  #   click_link "Review #{@restaurant.name}"
  #   expect {
  #     page.driver.submit :post, "/restaurants/#{@restaurant.id}/reviews", {"review"=>{"thoughts"=>"xyz", "rating"=>"123", "restaurant_id" => 1, "user_id" => 1}}
  #   }.not_to change(Review, :count)
  #
  # end

end
