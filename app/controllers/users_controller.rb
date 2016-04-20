class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]

	def index
	end

	def show
	end

	def new
		@user = User.new
	end

	def edit
	end

	def create
		@user = User.new(user_params)
		if @user.save
      		redirect_to employee_path, notice: "Thank you for signing up!"
      	else
      		render action: 'new'
      	end
	end

	def update
		if @employee.update(employee_params)
      		redirect_to employee_path, notice: "Successfully updated #{@user}."
    	else
      		render action: 'edit'
    	end
	end

	def destroy
		@user.destroy
		redirect_to employees_path, notice: "Successfully removed #{@user} from the AMC system."
	end

	private
	def set_user
		@user= User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end

end