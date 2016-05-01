class HomeController < ApplicationController

  def home
  	if logged_in? && current_user.employee.role == "manager"
      @incomplete_shifts = Shift.for_store(current_user.employee.current_assignment.store_id).past.incomplete.paginate(page: params[:page]).per_page(5)
    	@todays_shifts = Shift.for_store(current_user.employee.current_assignment.store_id).for_next_days(0).paginate(page: params[:page]).per_page(5)
    end
  end

  def about
  end

  def privacy
  end

  def contact
  end

end