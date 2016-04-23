class JobsController < ApplicationController
	before_action :set_job, only: [:show, :edit, :update, :destroy]
	before_action :check_login
  	authorize_resource

	def index
		@active_jobs = Job.active.alphabetical.paginate(page: params[:page]).per_page(10)
		@inactive_jobs = Job.inactive.alphabetical.paginate(page: params[:page]).per_page(10)
	end

	def show
		@shift_jobs = @job.shift_jobs.to_a
	end

	def new
		@job = Job.new
	end

	def edit
	end

	def create
		@job = Job.new(job_params)
		respond_to do |format|
			if @job.save
				format.html {redirect_to job_path(@job), notice: "Sucessfully created #{@job.name}."}
				format.json { render action: 'show', status: :created, location: @job }
			else
				format.html {render action: 'new'}
				format.json { render json: @jobs.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @job.update(job_params)
				format.html {redirect_to job_path(@job), notice: "Sucessfully updated #{@job.name}."}
				format.json { head :no_content }
			else
				format.html {render action: 'edit'}
				format.json { render json: @jobs.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@job.destroy
		respond_to do |format|
			format.html {redirect_to jobs_path, notice: "Sucessfully destroyed #{@job.name} from the AMC system."}
			format.json { head :no_content }
		end
	end

	private
	def set_job
		@job = Job.find(params[:id])
	end

	def job_params
		params.require(:job).permit(:name, :active)
	end

end