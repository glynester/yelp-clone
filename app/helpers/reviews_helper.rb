module ReviewsHelper
  def star_rating(rating)
     if rating.respond_to?(:round)
       remainder = (5 - rating.round)
       return "★" * rating.round + "☆" * remainder
     else
       rating
    end
  end
end
