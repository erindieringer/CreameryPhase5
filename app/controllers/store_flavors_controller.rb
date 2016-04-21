class StoreFlavorsController < ApplicationController
	before_action :set_store_flavor, only: [:show, :edit, :update, :destroy]

	def index
	end

	def show
	end

	def new
		@store_flavor = StoreFlavor.new
	end

	def edit
	end

	def create
		@store_flavor = StoreFlavor.new(store_flavor_params)
		if @store_flavor.save
      		redirect_to store_flavor_path, notice: "Thank you for signing up!"
      	else
      		render action: 'new'
      	end
	end

	def update
		if @store_flavor.update(store_flavor_params)
      		redirect_to store_flavor_path, notice: "Successfully updated #{@store_flavor}."
    	else
      		render action: 'edit'
    	end
	end

	private
	def set_store_flavor
		@store_flavor= StoreFlavor.find(params[:id])
	end

	def store_flavor_params
		params.require(:store_flavor).permit(:store_id, :flavor_id)
	end

end

end