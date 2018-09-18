class ProfilesController < ApplicationController
  # GET /profiles
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  def show
    @current_user = current_user
    @profile = Profile.find(params[:id])
  end

  # GET /profiles/new
  def new
    if current_user.profile
      redirect_to current_user.profile
    end
    @current_user = current_user
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
    @current_user = current_user
    @profile = Profile.find(params[:id])
  end

  # POST /profiles
  def create
    profile = Profile.create(profile_params)
    redirect_to profile
  end

  # PATCH/PUT /profiles/1
  def update
    profile = Profile.update(profile_params)
    redirect_to profile
  end

  # DELETE /profiles/1
  def destroy
    @profile.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_profile
    #   @profile = Profile.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:user_id, :fname, :lname, :rank)
    end
end
