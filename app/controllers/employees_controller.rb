class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource
  
  def index
    if current_user.employee.role == "manager" 
      @active_employees = Employee.active.alphabetical.to_a #.paginate(page: params[:page]).per_page(10) 
      @inactive_employees = Employee.inactive.alphabetical#.paginate(page: params[:page]).per_page(10)
    else
      @active_employees = Employee.active.alphabetical.paginate(page: params[:actives]).per_page(10) 
      @inactive_employees = Employee.inactive.alphabetical.paginate(page: params[:inactives]).per_page(10)
    end
  end

  def show
    # get the assignment history for this employee
    @assignments = @employee.assignments.chronological.paginate(page: params[:assignments]).per_page(5)
    # get upcoming shifts for this employee (later)
    @upcoming_shifts = @employee.current_assignment.shifts.upcoming.chronological unless @employee.current_assignment.nil?
    @past_shifts = @employee.current_assignment.shifts.past.chronological.paginate(page: params[:past]).per_page(5) unless @employee.current_assignment.nil?
    @user = @employee.user  
  end

  def new
    @employee = Employee.new
    user = @employee.build_user
    # @employee.user.build unless @employee.user.nil?
  end

  def edit
    if @employee.user.nil?
      user = @employee.build_user
    else
      user = @employee.user
    end
    
  end

  def create
    @employee = Employee.new(employee_params)
    respond_to do |format|
      if @employee.save
        format.html {redirect_to employee_path(@employee), notice: "Successfully created #{@employee.proper_name}."}
        format.json { render action: 'show', status: :created, location: @employee }
        @upcoming_shifts = @employee.current_assignment.shifts.upcoming.chronological unless @employee.current_assignment.nil?
        @past_shifts = @employee.current_assignment.shifts.past.chronological.paginate(page: params[:page]).per_page(5) unless @employee.current_assignment.nil?
        format.js
      else
        format.html {render action: 'new'}
        format.json { render json: @employee.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html {redirect_to employee_path(@employee), notice: "Successfully updated #{@employee.proper_name}."}
        format.json { head :no_content }
        format.js
      else
        format.html {render action: 'edit'}
        format.json { render json: @employee.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    @employee.destroy
    respond_to do |format|
      format.html {redirect_to employees_path, notice: "Successfully removed #{@employee.proper_name} from the AMC system."}
      format.json { head :no_content }
      format.js
    end
  end

  private
  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :ssn, :date_of_birth, :role, :phone, :active, user_attributes: [:email, :password, :password_confirmation, :_destroy])
  end

end