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
  end
end
