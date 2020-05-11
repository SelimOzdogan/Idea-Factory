class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can(:update, Idea) do |idea|
      idea.user == user
    end

    can(:destroy, Idea) do |idea|
      idea.user == user
    end

    can(:destroy, Review) do |review|
      review.user == user
    end

    can(:like, Idea) do |idea|
      user.present? && idea.user != user
    end

    can(:destroy, Like) do |like|
      like.user == user
    end
  end
end
