class LikesController < ApplicationController
  before_action :authenticated_user!, only: [:create, :destroy]

  def create
    idea = Idea.find params[:idea_id]
    like = Like.new(idea: idea, user: current_user)

    if !can?(:like, idea)
      flash[:alert] = "You can't like your own Idea"
    elsif like.save
      flash[:success] = "Idea Liked"
    else
      flash[:alert] = like.errors.full_messages.join(", ")
    end
    redirect_to ideas_path
  end

  def destroy
# byebug
    like = current_user.likes.find params[:id]

    if !can?(:destroy, like)
      flash[:warning] = "you can't destroy a like you don't own"
    elsif like.destroy
      flash[:success] = "Idea Unliked"
    else
      flash[:warning] = "It's rude to unlike something you've already liked"
    end

    redirect_to ideas_path
  end
end
