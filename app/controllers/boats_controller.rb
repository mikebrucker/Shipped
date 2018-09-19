class BoatsController < ApplicationController
  # GET /boats
  def index
    @boats = Boat.all
  end

  # GET /boats/1
  def show
    @boat = Boat.find(params[:id])
    @officer = officer(@boat.profile)
  end

  # GET /boats/new
  def new
    @boat = Boat.new
    @current_user = current_user
    @list = list.sort
  end

  # GET /boats/1/edit
  def edit
    @boat = Boat.find(params[:id])
    @current_user = current_user
    @list = list.sort
  end

  # POST /boats
  def create
    boat = Boat.create(boat_params)
    redirect_to boat
  end

  # PATCH/PUT /boats/1
  def update
    boat = Boat.find(params[:id])
    boat.update(boat_params)
    redirect_to boat
  end

  # DELETE /boats/1
  def destroy
    boat = Boat.find(params[:id])
    boat.destroy
    redirect_to boats_path
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def boat_params
      params.require(:boat).permit(:name, :max_containers, :location, :profile_id)
    end
end
