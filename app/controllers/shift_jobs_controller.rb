class ShiftJobsController < ApplicationController
	before_action :set_shift_job, only: [:show, :edit, :update, :destroy]

	def index
	end

	def show
	end

	def new
		@shift_job = ShiftJob.new
	end

	def edit
	end

	def create
		@shift_job = ShiftJob.new(shift_job_params)
		if @shift_job.save
      		redirect_to employee_path, notice: "Thank you for signing up!"
      	else
      		render action: 'new'
      	end
	end

	def update
		if @shift_job.update(shift_job_params)
      		redirect_to shift_job_path, notice: "Successfully updated #{@user}."
    	else
      		render action: 'edit'
    	end
	end

	private
	def set_shift_job
		@shift_job= ShiftJob.find(params[:id])
	end

	def shift_job_params
		params.require(:shift_job).permit(:job_id, :shift_id)
	end

end