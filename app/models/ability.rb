class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    if user.admin?
      puts "User is admin"
      can :access, :rails_admin
      can :manage, :all # Admin has full access
    else
      puts "User is not admin"
      can :access, :rails_admin
      can :read, :all # Non-admin users can read all resources

      # Allow non-admin users to manage their own user record
      can :manage, User, id: user.id
    end
  end
end
