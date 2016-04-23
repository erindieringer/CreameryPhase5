class ShiftJobsController < ApplicationController
	before_action :set_shift_job, only: [:show, :edit, :update, :destroy]

	def index
		@shift_jobs = ShiftJob.all
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
		respond_to do |format|
			if @shift_job.save
	      		format.html {redirect_to shifts_path, notice: "Thank you for signing up!"}
	      		@shift = @shift_job.shift
	      		@shift_jobs = @shift.shift_jobs
	      		@jobs = @shift_job.shift.jobs
	      		format.json { render action: 'show', status: :created, location: @shift_job }
	      		format.js
	      	else
	      		format.html {render action: 'new'}
	      		format.json { render json: @shift_jobs.errors, status: :unprocessable_entity }
	      		format.js
	      	end
	    end
	end

	def update
		respond_to do |format|
			if @shift_job.update(shift_job_params)
	      		format.html {redirect_to shifts_path, notice: "Successfully updated #{@user}."}
	      		@jobs = @shift_job.shift.jobs
	      		format.json { head :no_content }
	      		format.js
	    	else
	      		format.html {render action: 'edit'}
	      		format.json { render json: @shift_jobs.errors, status: :unprocessable_entity }
	      		format.js
	    	end
	    end
	end

	def destroy
		@shift_job.destroy
		respond_to do |format|
			format.html {redirect_to shift_path(@shift_job.shift), notice: "Sucessfully destroyed #{@shift_job.job.name} from the shift."}
			@jobs = @shift_job.shift.jobs
			format.json { head :no_content }
			format.js
		end
	end

	private
	def set_shift_job
		@shift_job = ShiftJob.find(params[:id])
	end

	def shift_job_params
		params.require(:shift_job).permit(:job_id, :shift_id)
	end

end