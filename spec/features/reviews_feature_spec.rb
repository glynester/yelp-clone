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
    # leave_review(restaurant: "KFC", thoughts: "I love it", rating: 4)
    expect(page).to_not have_link("Review KFC")
    # expect(page).to have_content("This restaurant has already been reviewed by you")
    # expect(page).not_to have_content("I love it")
  end


  # Not yet working!
  # Parameters: {"utf8"=>"✓", "authenticity_token"=>"sHjhWPyIqLFsxI1phQbgkbgsSvOtfkxSybupXXWab0YDeQCuJPEE+RUxf5vxK0exjiV9yOQQed0IiqYM7860wQ==",
  #   "review"=>{"thoughts"=>"greatest", "rating"=>"5"}, "commit"=>"Leave Review", "restaurant_id"=>"4"}
  # Need to diable "validates :user, uniqueness: { scope: :restaurant, message: "has reviewed this restaurant already" }" on review model, to test
  # scenario "cannot add a review if reviewed already" do
  #   user = User.create(email: 'joe@joe.com', password: 'joejoe', password_confirmation: 'joejoe')
  #   restaurant = Restaurant.create(name: "Cafe del Mar", description: "On the beach al fresco", user_id: user.id)
  #   visit "/restaurants"
  #   expect(page).to have_content("Cafe del Mar")
  #     # leave_review(restaurant: restaurant.name, thoughts: "so so", rating: 3)
  #   expect {
  #     page.driver.submit :post, "/restaurants/#{restaurant.id}/reviews", {"review"=>{"thoughts"=>"xyz", "rating"=>4 },"restaurant_id" => restaurant.id}
  #     # page.driver.submit :post, "/restaurants/#{restaurant.id}/reviews", {"review"=>{"thoughts"=>"xyz", "rating"=>4, "restaurant_id" => restaurant.id, "user_id" => user.id}}
  #   }.to change(Review, :count)
  #   p review
  # end

  scenario "displays an average rating for all reviews" do
    sign_up_and_sign_in
    create_restaurant
    click_link "Sign out"
    sign_up_and_sign_in(email: 'jack@jack.com', password: 'jacjac')
    leave_review
    click_link "Sign out"
    sign_up_and_sign_in(email: 'jon@jon.com', password: 'jonjon')
    leave_review(restaurant: "KFC", thoughts: "Not too bad", rating: 4)
    expect(page).to have_content("Star rating: ★★★★☆")

  end




end
