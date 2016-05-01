class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]
  before_action :check_login, only: [:edit, :update, :destroy]
  authorize_resource
  
  def index
    @active_stores = Store.active.alphabetical.paginate(page: params[:page]).per_page(10)
    @inactive_stores = Store.inactive.alphabetical.paginate(page: params[:page]).per_page(10) 
    @stores = Store.all.active
  end

  def show
    @current_assignments = @store.assignments.current.paginate(page: params[:page]).per_page(8)
    @current_flavors = @store.store_flavors.all.paginate(page: params[:page]).per_page(10)
    @store_shifts = [] 
    @store.assignments.current.each do |assignment| 
      unless assignment.shifts.for_next_days(7).empty? 
        assignment.shifts.for_next_days(7).each do |shift| 
          @store_shifts.push(shift) 
        end 
      end 
    end
    @store_shifts = @store_shifts.sort.paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @store = Store.new
  end

  def edit
  end

  def create
    @store = Store.new(store_params)
    respond_to do |format|
      if @store.save
        format.html {redirect_to store_path(@store), notice: "Successfully created #{@store.name}."}
        format.json { render action: 'show', status: :created, location: @store}
      else
        format.html {render action: 'new'}
        format.json { render json: @stores.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format| 
      if @store.update(store_params)
        format.html {redirect_to store_path(@store), notice: "Successfully updated #{@store.name}."}
        format.json { head :no_content }
      else
        format.html {render action: 'edit'}
        format.json { render json: @stores.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @store.destroy
    respond_to do |format|  
      format.html {redirect_to stores_path, notice: "Successfully removed #{@store.name} from the AMC system."}
      format.json { head :no_content }
    end
  end

  private
  def set_store
    @store = Store.find(params[:id])
  end

  def store_params
    params.require(:store).permit(:name, :street, :city, :state, :zip, :phone, :active)
  end

end