class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    if @review.save
    else
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body, :spot_id, :visitor_id)
  end
end
