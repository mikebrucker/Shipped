class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

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
    @list = list.sort
  end

  # GET /jobs/1/edit
  def edit
    @job = Job.find(params[:id])
    @list = list.sort
  end

  # POST /jobs
  def create
    job = Job.create(job_params)
    redirect_to job
  end

  # PATCH/PUT /jobs/1
  def update
    job = Job.find(params[:id])
    job.update(job_params)
    redirect_to job
  end

  # DELETE /jobs/1
  def destroy
    @job.destroy
    redirect_to jobs_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:name, :desc, :origin, :destination, :cost, :containers)
    end
end
