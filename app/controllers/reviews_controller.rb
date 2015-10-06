class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    if @review.save
    else
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body, :spot_id, :visitor_id)
  end
end
