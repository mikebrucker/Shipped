class SchedulesController < ApplicationController
  # GET /schedules
  def index
    @schedules = Schedule.all
  end

  # GET /schedules/1
  def show
    @schedule = Schedule.find(params[:id])
  end
  
  # GET /schedules/new
  def new
    @schedule = Schedule.new
  end
  
  # GET /schedules/1/edit
  def edit
    @schedule = Schedule.find(params[:id])
  end

  # POST /schedules
  def create
    schedule = Schedule.create(schedule_params)
    redirect_to schedule
  end
  
  # PATCH/PUT /schedules/1
  def update
    schedule = Schedule.find(params[:id])
    schedule.update(schedule_params)
    redirect_to schedule
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
