module ShiftsHelper
	
	def get_assignment_options
		if logged_in? && current_user.employee.role == "manager"
			Assignment.current.for_store(current_user.employee.current_assignment.store_id).all.to_a.map{ |a| [ "#{a.employee.name}"]}.sort
		else
			Assignment.current.all.to_a.map{ |a| [ "#{a.employee.name}"]}.sort
		end
	end

	def get_complete_options
		Shift.for_store(current_user.employee.current_assignment.store_id).past.incomplete.all.to_a.map{ |a| [ "#{a.assignment.employee.proper_name}, #{a.date.strftime("%m/%d/%y")}, #{a.start_time.strftime("%r")} "]}
	end

end