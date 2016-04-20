class ShiftsController < ApplicationController
	before_action :set_shift, only: [:show, :edit, :update, :destroy]

	def index
		@upcoming_shifts = Shift.upcoming.by_store.paginate(page: params[:page]).per_page(10)
		@past_shifts = Shift.past.by_store.paginate(page: params[:page]).per_page(10)
	end

	def show
		@assignment = @shift.assignment
		@jobs = nil #@shift.shift_jobs
	end

	def new
		@shift = Shift.new
	end

	def edit
	end

	def create
		@shift = Shift.new(shift_params)
		if @shift.save
			redirect_to shift_path(@shift), notice: "Sucessfully created new shift on #{@shift.date} for #{@shift.assignment.store}."
		else
			render action: 'new'
		end
	end

	def update
		if @shift.update(shift_params)
			redirect_to shift_path(@shift), notice: "Sucessfully update shift on #{@shift.date} for #{@shift.assignment.store}."
		else
			render action: 'edit'
		end
	end

	def destroy
		@shift.destroy
		redirect_to shifts_path, notice: "Sucessfully destroyed shift for #{@shift.assignment.employee.name} on #{@shift.date} at #{@shift.assignment.store} from the AMC system."
	end

	private
	def set_shift
		@shift = Shift.find(params[:id])
	end

	def shift_params
		params.require(:shift).permit(:assignment_id, :date, :start_time)
	end

end