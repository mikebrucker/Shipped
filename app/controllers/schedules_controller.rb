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
    redirect_back(fallback_location: root_path)
  end
  
  # PATCH/PUT /schedules/1
  def update
    if params[:schedule][:start] < params[:schedule][:finish]
      schedule = Schedule.find(params[:id])
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
    schedule.destroy
    redirect_to schedules_path
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def schedule_params
    params.require(:schedule).permit(:boat_id, :job_id, :start, :finish)
  end
end
