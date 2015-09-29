class ReviewsController < ApplicationController

  def create
    review = Review.new(review_params)
    binding.pry
    if review.save
      redirect_to spot_path(params[:review][:spot_id])
    else
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body, :spot_id, :visitor_id)
  end
end
