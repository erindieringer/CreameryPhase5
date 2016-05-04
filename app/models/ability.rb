class Ability
  include CanCan::Ability

  def initialize(user)
  	user ||= User.new

  	#authorization for admin
    if user.role? :admin
      can :manage, :all
     
     elsif user.role? :manager
     	can :read, Store
      can :read, Job
      can :read, Flavor

      can :read, Employee do |employees|
        managed_store = user.employee.current_assignment.store_id
        employees.current_assignment.store_id == managed_store
      end

      can :read, Assignment do |assign|
        managed_store = user.employee.current_assignment.store_id
        assign.store_id == managed_store
      end

      can :read,  Shift do |s|
        managed_store = user.employee.current_assignment.store_id
        s.assignment.store_id = managed_store
      end

      can :create, Shift do |s|
        managed_store = user.employee.current_assignment.store_id
        s.assignment.store_id = managed_store
      end

      can :destroy, Shift do |s|
        managed_store = user.employee.current_assignment.store_id
        s.assignment.store_id = managed_store
      end

      can :update, Shift do |s|
        managed_store = user.employee.current_assignment.store_id
        s.assignment.store_id = managed_store
      end

      can :complete, Shift do |s|
        managed_store = user.employee.current_assignment.store_id
        s.assignment.store_id = managed_store
      end

      can :destroy, ShiftJob do |s|
        managed_store = user.employee.current_assignment.store_id
        s.shift.assignment.store_id = managed_store
      end

      can :create, ShiftJob do |s|
        managed_store = user.employee.current_assignment.store_id
        s.shift.assignment.store_id = managed_store
      end

      can :destroy, StoreFlavor do |s|
        managed_store = user.employee.current_assignment.store_id
        s.store_id = managed_store
      end

      can :create, StoreFlavor do |s|
        managed_store = user.employee.current_assignment.store_id
        s.store_id = managed_store
      end

      can :start_now, Shift do |s|
        s.assignment_id == user.employee.current_assignment.id
      end

      can :end_now, Shift do |s|
        s.assignment_id == user.employee.current_assignment.id
      end

     elsif user.role? :employee
     	can :read, Employee do |e|
        e.id == user.employee.id
      end

      can :show, Employee do |e|
        e.id == user.employee.id
      end

      can :update, Employee do |e|
        e.id == user.employee.id
      end
      
      can :read, Store

      can :read, Assignment do |a|
        a.employee_id == user.employee_id
      end

      can :read, Shift do |s|
        s.assignment_id == user.employee.current_assignment.id
      end

      can :read, ShiftJob do |s|
        s.shift.assignment_id == user.employee.current_assignment.id
      end

      can :read, User do |u|
        u.id == user.id
      end
      can :read, Job 

      can :start_now, Shift do |s|
        s.assignment_id == user.employee.current_assignment.id
      end

      can :end_now, Shift do |s|
        s.assignment_id == user.employee.current_assignment.id
      end




     else
     	can :read, Store
     end	
    
  end
end
