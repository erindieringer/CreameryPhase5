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
		@user = current_user
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
      		redirect_to employee_path, notice: "Thank you for signing up!"
      	else
      		render action: 'new'
      	end
	end

	def update
		@user = current_user
		if @user.update(user_params)
      		redirect_to employee_path, notice: "Successfully updated #{@user}."
    	else
      		render action: 'edit'
    	end
	end

	private
	def set_user
		@user= User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end

end