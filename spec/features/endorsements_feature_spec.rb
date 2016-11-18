require 'rails_helper'

feature 'endorsing reviews' do
  before do
    user = User.create(email: 'joe@joe.com', password: 'joejoe', password_confirmation: 'joejoe')
    kfc = Restaurant.create(name: 'KFC', user_id: user.id)
    kfc.reviews.create(rating: 3, thoughts: 'It was an abomination', user_id: user.id)
  end

  scenario 'a user can endorse a review, which updates the review endorsement count' do
    visit '/restaurants'
    click_link 'Endorse Review' #are we endorsing restaurants or the review of the restaurants?
    expect(page).to have_content('1 endorsement')
  end

end
