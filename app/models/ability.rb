class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, User
    
    if user && user.admin
      can :manage, :all
    elsif user
      #can :create, Upload
      #can :manage, Upload, user_id: user.id

      can :manage, User, _id: user.id
    end
  end
end
