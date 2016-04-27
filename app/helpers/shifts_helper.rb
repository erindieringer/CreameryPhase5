module ShiftsHelper
	
	def get_assignment_options
		Assignment.current.all.to_a.map{ |a| [ "#{a.employee.name}"]}
	end

end