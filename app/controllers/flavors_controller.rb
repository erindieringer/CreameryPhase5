class FlavorsController < ApplicationController
	before_action :set_flavor, only: [:show, :edit, :update, :destroy]


	def index
		@active_flavors = Flavor.active.alphabetical.paginate(page: params[:page]).per_page(10)
		@inactive_flavors = Flavor.inactive.alphabetical.paginate(page: params[:page]).per_page(10)
	end

	def show
		@store_flavors = @flavor.store_flavors
	end

	def new
		@flavor = Flavor.new
	end

	def edit
	end

	def create
		@flavor = Flavor.new(flavor_params)
		respond_to do |format|
			if @flavor.save
				format.html {redirect_to flavor_path(@flavor), notice: "Sucessfully created #{@flavor.name}."}
				format.json { render action: 'show', status: :created, location: @flavor }
			else
				format.html {render action: 'new'}
				format.json { render json: @flavors.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|	
			if @flavor.update(flavor_params)
				format.html {redirect_to flavor_path(@flavor), notice: "Sucessfully updated #{@flavor.name}."}
				format.json { head :no_content }
			else
				format.html {render action: 'edit'}
				format.json { render json: @flavors.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@flavor.destroy
		respond_to do |format|
			format.html {redirect_to flavors_path, notice: "Sucessfully destroyed #{@flavor.name} from the AMC system."}
			format.json { head :no_content }
		end
	end

	private
	def set_flavor
		@flavor = Flavor.find(params[:id])
	end

	def flavor_params
		params.require(:flavor).permit(:name, :active)
	end

end