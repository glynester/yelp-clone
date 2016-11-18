require "rails_helper"
describe "Restaurant", type: :model do
  it "is not valid with a name shorter than 3 chars" do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it "is not valid unless the name is unique" do
    user = User.create(email: 'joe@joe.com', password: 'joejoe', password_confirmation: 'joejoe')
    Restaurant.create(name: "Chicken Inn", user_id: user.id)
    restaurant = Restaurant.new(name: "Chicken Inn")
    expect(restaurant).to have(1).error_on :name
  end

end

describe '#average rating' do
  context 'no reviews' do
    it 'returns "N/A" when there are no reviews' do
      user = User.create(email: 'joe@joe.com', password: 'joejoe', password_confirmation: 'joejoe')
      restaurant = Restaurant.create(name: "Beachcomber", user_id: user.id)
      expect(restaurant.average_rating).to eq 'N/A'
    end
  end

  context 'one review' do
    it 'returns that rating' do
      user = User.create(email: 'joe@joe.com', password: 'joejoe', password_confirmation: 'joejoe')
      second_user = User.create(email: 'jack@jack.com', password: 'jackjack', password_confirmation: 'jackjack')
      restaurant = Restaurant.create(name: "Beachcomber", user_id: user.id)
      restaurant.reviews.create(rating: 4, user_id: second_user.id)
      expect(restaurant.average_rating).to eq 4
    end
  end

  context 'multiple reviews' do
    it 'returns the average rating' do
      user = User.create(email: 'joe@joe.com', password: 'joejoe', password_confirmation: 'joejoe')
      second_user = User.create(email: 'jack@jack.com', password: 'jackjack', password_confirmation: 'jackjack')
      third_user = User.create(email: 'jim@jim.com', password: 'jimjim', password_confirmation: 'jimjim')
      restaurant = Restaurant.create(name: "Beachcomber", user_id: user.id)
      restaurant.reviews.create(rating: 1, user_id: second_user.id)
      restaurant.reviews.create(rating: 3, user_id: third_user.id)
      expect(restaurant.average_rating).to eq 2
    end
  end



end
