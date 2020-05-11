class Ability
    include CanCan::Ability
  
    def initialize(user)
      user ||= User.new
  
      can(:update, Idea) do |idea|#edit
        idea.user == user
      end
  
      can(:destroy, Idea) do |idea|#delete
        idea.user == user
        end
  
      can(:destroy, Review) do |review|#delete
        review.user == user || review.post.user == user
        end
  
      can(:update, User) do |user_edit|#edit
          user == user_edit
        end
    end
  end
  