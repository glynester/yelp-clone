def sign_up_and_sign_in(email: 'joe@joe.com', password: 'joejoe')
  visit '/users/sign_up'
  fill_in "Email", with: email
  fill_in "Password", with: password
  fill_in "Password confirmation", with: password
  click_button 'Sign up'
end

def create_restaurant(name: 'KFC', description: 'Finger lickin')
  visit '/restaurants/new'
  fill_in 'Name', with: name
  fill_in 'Description', with: description
  click_button "Create Restaurant"
end

def leave_review(restaurant: "KFC", thoughts: "so so", rating: 3)
  click_link "Review #{restaurant}"
  fill_in "Thoughts", with: thoughts
  select rating, from: "Rating"
  click_button 'Leave Review'
end
