class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    unless user.new_record?
      # Facts
      can [:edit,:update,:destroy], Fact if user.admin?
      can [:edit,:update,:destroy], Fact, :user_id => user.id
      can [:new,:create], Fact

      # Comments
      can :create, Comment
      can :destroy, Comment if user.admin?
      can :destroy, Comment, :user_id => user.id
      can :destroy, Comment, :fact => { :user_id => user.id }

      # Tags
      can [:create,:destroy], Tag
    end
    can :read, [Fact,Comment,Tag]
  end
end
