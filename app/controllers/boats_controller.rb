class BoatsController < ApplicationController
  before_action :authenticate_user!

  # GET /boats
  def index
    @boats = Boat.all
  end

  # GET /boats/1
  def show
    @boat = Boat.find(params[:id])
  end

  # GET /boats/new
  def new
    @boat = Boat.new
    @list = location_list.sort
  end

  # GET /boats/1/edit
  def edit
    @boat = Boat.find(params[:id])
    unless current_user == @boat.profile.user
      redirect_to boats_path
    end
    @list = location_list.sort
  end

  # POST /boats
  def create
    if ["..SS", ".SS", "SS", "..S", ".S", "S", "..", "."].include?(params[:boat][:name].gsub(/[[:space:]]/, '').chars.sort.join.upcase) || params[:boat][:name].gsub(/[[:space:]]/, '') == ""
      flash[:notice] = "Please Name Your Boat Properly"
      redirect_back(fallback_location: root_path)
    elsif params[:boat][:name] == Boat.where(name: params[:boat][:name]).first
      flash[:notice] = "Boat Name Already Taken"
      redirect_back(fallback_location: root_path)
    else
      boat = Boat.create(boat_params)
      boat.avatar.attach(params[:boat][:avatar])
      flash[:success] = "Boat #{boat.name} Created"
      redirect_to boat
    end
  end

  # PATCH/PUT /boats/1
  def update
    boat = Boat.find(params[:id])
    if ["..SS", ".SS", "SS", "..S", ".S", "S", "..", "."].include?(params[:boat][:name].gsub(/[[:space:]]/, '').chars.sort.join.upcase) || params[:boat][:name].gsub(/[[:space:]]/, '') == ""
      flash[:notice] = "Please Name Your Boat Properly"
    elsif boat.name != params[:boat][:name]
      if params[:boat][:name] == Boat.where(name: params[:boat][:name]).first
        flash[:notice] = "Boat Name Already Taken"
      end
    elsif current_user == boat.profile.user
      flash[:success] = "Boat #{boat.name} Updated"
      boat.update(boat_params)
      boat.avatar.attach(params[:boat][:avatar])
    elsif boat.name == params[:boat][:name] && current_user == boat.profile.user
      flash[:success] = "Boat #{boat.name} Updated"
      boat.update(boat_params)
      boat.avatar.attach(params[:boat][:avatar])
    end
    redirect_to boat
  end

  # DELETE /boats/1
  def destroy
    boat = Boat.find(params[:id])
    if current_user == boat.profile.user
      boat.schedules.destroy_all
      if boat.destroy
        flash[:success] = "Boat Removed"
      else
        flash[:error] = "There Was a Problem Removing This Boat"
      end
      redirect_to boats_path
      return
    end
    flash[:notice] = "You Arrrrrrgh Not This Ship's Captain"
    redirect_back(fallback_location: root_path)
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def boat_params
    params.require(:boat).permit(:name, :max_containers, :location, :profile_id, :avatar)
  end
end
