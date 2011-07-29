class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :read, [Fact,Comment,Tag]
    unless user.new_record?
      if user.admin?
        can :manage, :all
      else
        # Facts
        can [:edit,:update,:destroy], Fact, :user_id => user.id
        can [:new,:create], Fact

        # Comments
        can :create, Comment
        can :destroy, Comment, :user_id => user.id
        can :destroy, Comment, :fact => { :user_id => user.id }

        # Tags
        can [:create,:destroy], Tag
      end
    end
  end
end
