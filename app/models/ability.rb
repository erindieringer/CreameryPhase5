class Ability
  include CanCan::Ability

  def initialize(user)
  	user ||= User.new

  	#authorization for admin
    if user.role? :admin
      # they get to do it all
      can :manage, :all
     elsif user.role? :manager
     	can :index, Employee
     elsif user.role? :employee
     	can :show, Employee
     else
     	can :read, Domain
     end	
    
  end
end
