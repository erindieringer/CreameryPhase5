class HomeController < ApplicationController

  def home
  	if logged_in? && current_user.employee.role == "manager"
      @incomplete_shifts = Shift.chronological.for_store(current_user.employee.current_assignment.store_id).past.incomplete.paginate(page: params[:page]).per_page(5)
    	@todays_shifts = Shift.for_store(current_user.employee.current_assignment.store_id).for_next_days(0).paginate(page: params[:shifts_today]).per_page(5)
      @current_store_flavors = current_user.employee.current_assignment.store.store_flavors
      @shift = @incomplete_shifts.first
    else
      @incomplete_shifts = Shift.incomplete.all.paginate(page: params[:page]).per_page(5)
    end
    @active_flavors = Flavor.active.alphabetical.paginate(page: params[:page3]).per_page(10)
    @active_stores = Store.active.alphabetical
    @shifts_today = Shift.for_next_days(0).by_store.paginate(page: params[:todays]).per_page(5)
    @active_employees = Employee.active.regulars.all.paginate(page: params[:employees]).per_page(5)
    @active_managers = Employee.active.managers.all.paginate(page: params[:managers]).per_page(5)
    @active_admins = Employee.active.admins.all.paginate(page: params[:admins]).per_page(5)



  end

  def about
  end

  def privacy
  end

  def contact
  end

end