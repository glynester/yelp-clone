class ReviewsController < ApplicationController
before_action :authenticate_user!

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    restaurant = Restaurant.find(params[:restaurant_id])
      if current_user and current_user.has_reviewed?(restaurant)
        flash[:notice] = "This restaurant has already been reviewed by you"
      end
    # @restaurant.reviews.create(review_params)
    review = Review.new(review_params)
    review.user_id = current_user.id
    review.restaurant_id = restaurant.id
    review.save
    redirect_to "/restaurants"
  end

  private
  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
