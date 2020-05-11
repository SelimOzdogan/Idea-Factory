class ReviewsController < ApplicationController
    before_action :authenticated_user!, except: [:index, :show]
  
    # before_action :authorize!, only: [:edit, :update, :destroy]
    
    def create
      @idea = Idea.find(params[:idea_id])
      @review = Review.new review_params
      @review.user = @current_user
      @review.idea = @idea
      if @review.save
        redirect_to @idea
      else
        @reviews = @idea.reviews.order(created_at: :desc)
        render "ideas/show"
      end
    end
  
    def destroy
      @review = Review.find params[:id]
      @review.destroy
      redirect_to @review.idea
    end
  
    private
  
    def review_params
      params.require(:review).permit(:body)
    end
end
