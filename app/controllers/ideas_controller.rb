class IdeasController < ApplicationController
   before_action :authenticated_user!, except: [:index, :show]

  # # before_action :authorize!, only: [:edit, :update, :destroy]

  before_action :find_idea, only: [:show, :edit, :update, :destroy]

  def index
    @ideas = Idea.all.order(updated_at: :desc)
    @likes = Like.where(user: current_user)
  end

  def new
    @idea = Idea.new
  end

  def show
    @review = Review.new
    @reviews = @idea.reviews.order(updated_at: :desc)
  end

  def create
    @idea = Idea.new idea_params
    @idea.user = @current_user
    if @idea.save
      redirect_to @idea
    else
      render :new
    end
  end

  def update
    if !can?(:update, @idea)
      flash[:warning] = "You can't update a idea you don't own"
      redirect_to root_path
    else
      if @idea.update idea_params
        redirect_to idea_path(@idea)
      else
        render :edit
      end
    end
  end

  def destroy
    if !can?(:destroy, @idea)
      flash[:warning] = "You can't delete a idea you don't own"
      redirect_to root_path
    else
      @idea.destroy
      redirect_to ideas_path
    end
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :description)
  end

  def find_idea
    @idea = Idea.find params[:id]
  end
end
