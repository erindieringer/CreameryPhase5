class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource

  def index
    @current_assignments = Assignment.current.by_store.by_employee.chronological.paginate(page: params[:page]).per_page(15)
    @past_assignments = Assignment.past.by_employee.by_store.paginate(page: params[:page]).per_page(15)  
  end

   def show
      authorize! :show, @assignment
      @shifts = @assignment.shifts.chronological.paginate(page: params[:page]).per_page(5) 
    
   end

  def new
    @assignment = Assignment.new
    # if params[:from].nil?
    #   if params[:id].nil?
    #     @assignment = Assignment.new
    #   else
    #     @assignment = Assignment.find(params[:id])
    #   end
    # else
    #   @assignment = Assignment.new
    #   if params[:from] == "store" 
    #     @assignment.store_id = params[:id]
    #   else
    #     @assignment.employee_id = params[:id]
    #   end
    # end
  end

  def edit
  end

  def create
    @assignment = Assignment.new(assignment_params)
    
    if @assignment.save
      redirect_to assignments_path, notice: "#{@assignment.employee.proper_name} is assigned to #{@assignment.store.name}."
      # redirect_to assignment_path(@assignment), notice: "#{@assignment.employee.proper_name} is assigned to #{@assignment.store.name}."
    else
      render action: 'new'
    end
  end

  def update
    if @assignment.update(assignment_params)
      redirect_to assignments_path, notice: "#{@assignment.employee.proper_name}'s assignment to #{@assignment.store.name} is updated."
    else
      render action: 'edit'
    end
  end

  def destroy
    @assignment.destroy
    redirect_to assignments_path, notice: "Successfully removed #{@assignment.employee.proper_name} from #{@assignment.store.name}."
  end

  private
  def convert_start_and_end_dates
      params[:assignment][:start_date] = convert_to_date(params[:assignment][:start_date]) unless params[:assignment][:start_date].blank?
      params[:assignment][:end_date] = convert_to_date(params[:assignment][:end_date]) unless params[:assignment][:end_date].blank?
  end
  def set_assignment
    @assignment = Assignment.find(params[:id])
  end

  def assignment_params
    convert_start_and_end_dates
    params.require(:assignment).permit(:employee_id, :store_id, :start_date, :end_date, :pay_level)
  end

end