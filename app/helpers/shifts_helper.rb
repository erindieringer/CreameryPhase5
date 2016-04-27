module ShiftsHelper
	
	def get_assignment_options
		if logged_in? && current_user.employee.role == "manager"
			Assignment.current.for_store(current_user.employee.current_assignment.store_id).all.to_a.map{ |a| [ "#{a.employee.name}"]}.sort
		else
			Assignment.current.all.to_a.map{ |a| [ "#{a.employee.name}"]}
		end
	end

end