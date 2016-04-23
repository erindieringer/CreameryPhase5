class StoreFlavorsController < ApplicationController
	before_action :set_store_flavor, only: [:show, :edit, :update, :destroy]

	def index
	end

	def show
		@store_flavors= StoreFlavor.all
	end

	def new
		@store_flavor = StoreFlavor.new
	end

	def edit
	end

	def create
		@store_flavor = StoreFlavor.new(store_flavor_params)
		respond_to do |format|	
			if @store_flavor.save
	      		format.html {redirect_to store_flavor_path, notice: "Thank you for signing up!"}
	      		format.json { render action: 'show', status: :created, location: @store_flavor }
	      	else
	      		format.html {render action: 'new'}
	      		format.json { render json: @store_flavors.errors, status: :unprocessable_entity }
	      	end
	    end
	end

	def update
		respond_to do |format|
			if @store_flavor.update(store_flavor_params)
	      		format.html {redirect_to store_flavor_path, notice: "Successfully updated #{@store_flavor}."}
	      		format.json { head :no_content }
	    	else
	      		format.html {render action: 'edit'}
	      		format.json { render json: @store_flavors.errors, status: :unprocessable_entity }
	    	end
	    end
	end

	def destroy
		@store_flavor.destroy
		respond_to do |format|
			format.html {redirect_to store_flavors_path, notice: "Sucessfully destroyed from the AMC system."}
			format.json { head :no_content }
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