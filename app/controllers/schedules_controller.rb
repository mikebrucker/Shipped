class SchedulesController < ApplicationController
  before_action :authenticate_user!

  # GET /schedules
  def index
    @schedules = Schedule.all.sort_by{ |s| s.job.name.downcase}
  end

  # GET /schedules/1
  def show
    @schedule = Schedule.find(params[:id])
  end
  
  # GET /schedules/new
  def new
    @schedule = Schedule.new
    @today = Date.current
  end
  
  # GET /schedules/1/edit
  def edit
    @schedule = Schedule.find(params[:id])
    unless current_user == @schedule.boat.profile
      redirect_to schedules_path
    end
    @today = Date.current
  end

  # POST /schedules
  def create
    Boat.find(params[:schedule][:boat_id]).schedules.each do |s|
      if s.start.between?(params[:schedule][:start], params[:schedule][:finish]) || s.finish.between?(params[:schedule][:start], params[:schedule][:finish])
        flash[:error] = "Boat is already Scheduled between #{params[:schedule][:start].to_s} and #{params[:schedule][:finish].to_s}"
        redirect_back(fallback_location: root_path)
        return
      end
    end
    current_user.profile.boats.each do |b|
      if b.id == params[:schedule][:boat_id].to_i
        if params[:schedule][:start] < params[:schedule][:finish]
          schedule = Schedule.create(schedule_params)
          flash[:success] = "Schedule Created"
          redirect_to schedule
          return
        elsif params[:schedule][:start] >= params[:schedule][:finish]
          flash[:error] = "Schedule Finish Date Must Be After Start Date"
        else 
          flash[:error] = "Schedule Unable To Be Created"
        end
      end
    end
    redirect_back(fallback_location: root_path)
  end
  
  # PATCH/PUT /schedules/1
  def update
    schedule = Schedule.find(params[:id])
    unless current_user == schedule.boat.profile
      redirect_to schedule
      return
    end
    if params[:schedule][:start] < params[:schedule][:finish]
      schedule.update(schedule_params)
      flash[:success] = "Schedule Updated"
      redirect_to schedule
      return
    elsif params[:schedule][:start] >= params[:schedule][:finish]
      flash[:error] = "Schedule Finish Date Must Be After Start Date"
    else 
      flash[:error] = "Schedule Unable To Be Updated"
    end
    redirect_back(fallback_location: root_path)
  end
  
  # DELETE /schedules/1
  def destroy
    schedule = Schedule.find(params[:id])
    if current_user == schedule.boat.profile
      flash[:notice] = "Schedule Removed"
      schedule.destroy
    else
      flash[:error] = "You are not the boat captain."
    end
    redirect_to schedules_path
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def schedule_params
    params.require(:schedule).permit(:boat_id, :job_id, :start, :finish)
  end
end
