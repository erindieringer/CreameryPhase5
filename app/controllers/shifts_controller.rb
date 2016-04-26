class ShiftsController < ApplicationController
	before_action :set_shift, only: [:show, :edit, :update, :destroy]
	before_action :check_login
  	authorize_resource

	def index
		@upcoming_shifts = Shift.upcoming.by_store.paginate(page: params[:page]).per_page(10)
		@past_shifts = Shift.past.by_store.paginate(page: params[:page]).per_page(10)
	end

	def show
		@assignment = @shift.assignment
		@jobs = @shift.shift_jobs
		@shifts = @assignment.employee.shifts
		@upcoming_shifts = Shift.upcoming.by_store
	end

	def new
		@shift = Shift.new
	end

	def edit
	end

	def create
		@shift = Shift.new(shift_params)
		respond_to do |format|
			if @shift.save
				format.html {redirect_to shift_path(@shift), notice: "Sucessfully created new shift on #{@shift.date} for #{@shift.assignment.store}."}
				format.json { render action: 'show', status: :created, location: @shift }
				@jobs = @shift.shift_jobs
				@assignment = @shift.assignment
				@shifts = @assignment.employee.shifts
				format.js
			else
				format.html {render action: 'new'}
				format.json { render json: @shift.errors, status: :unprocessable_entity }
				format.js
			end
		end
	end

	def update
		respond_to do |format|
			if @shift.update(shift_params)
				format.html {redirect_to shift_path(@shift), notice: "Sucessfully update shift on #{@shift.date} for #{@shift.assignment.store}."}
				format.json { head :no_content }
				@jobs = @shift.shift_jobs
				format.js
			else
				format.html {render action: 'edit'}
				format.json { render json: @shift.errors, status: :unprocessable_entity }
				format.js
			end
		end
	end

	def destroy
		@shift.destroy
		respond_to do |format|
			format.html {redirect_to shifts_path, notice: "Sucessfully destroyed shift for #{@shift.assignment.employee.name} on #{@shift.date} at #{@shift.assignment.store.name} from the AMC system."}
			format.json { head :no_content }
			@jobs = @shift.shift_jobs
			format.js

		end
	end

	private
	def set_shift
		@shift = Shift.find(params[:id])
	end

	def shift_params
		params.require(:shift).permit(:assignment_id, :date, :start_time)
	end

end