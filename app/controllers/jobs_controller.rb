class JobsController < ApplicationController
  # GET /jobs
  def index
    @jobs = Job.all
  end

  # GET /jobs/1
  def show
    @job = Job.find(params[:id])
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
    @job = Job.find(params[:id])
  end

  # POST /jobs
  def create
    if params[:job][:destination] == params[:job][:origin]
      flash[:error] = "Origin Cannot Be The Destination"
      redirect_back(fallback_location: root_path)
    else
      job = Job.create(job_params)
      flash[:success] = "Job #{job.name} Created Successfully"
      redirect_to job
    end
  end

  # PATCH/PUT /jobs/1
  def update
    if params[:job][:destination] == params[:job][:origin]
      flash[:error] = "Origin Cannot Be The Destination"
      redirect_back(fallback_location: root_path)
    else
      job = Job.find(params[:id])
      job.update(job_params)
      flash[:success] = "Job #{job.name} Updated Successfully"
      redirect_to job
    end
  end
  
  # DELETE /jobs/1
  def destroy
    job = Job.find(params[:id])
    job.schedules.destroy_all
    if job.destroy
      flash[:success] = "Job Removed"
    else
      flash[:error] = "There Was a Problem Removing This Job"
    end
    redirect_to jobs_path
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def job_params
    params.require(:job).permit(:name, :desc, :origin, :destination, :cost, :containers)
  end
end
