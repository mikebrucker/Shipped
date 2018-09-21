class ProfilesController < ApplicationController
  # GET /profiles
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  def show
    @profile = Profile.find(params[:id])
  end

  # GET /profiles/new
  def new
    if current_user.profile
      redirect_to current_user.profile
    end
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
    @profile = Profile.find(params[:id])
    if current_user != @profile.user
      redirect_to @profile
    end 
  end

  # POST /profiles
  def create
    profile = Profile.create(profile_params)
    flash[:success] = "#{profile.officer}'s Profile Created"
    redirect_to profile
  end

  # PATCH/PUT /profiles/1
  def update
    profile = Profile.find(params[:id])
    profile.update(profile_params)
    flash[:success] = "#{profile.officer}'s Profile Updated"
    redirect_to profile
  end
  
  # DELETE /profiles/1 [I do not want the ability to delete a profile / Only update it]
  def destroy
    profile = Profile.find(params[:id])
    flash[:error] = "#{profile.officer}'s Profile Can Only Be Edited"
    redirect_to profile
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
    params.require(:profile).permit(:user_id, :fname, :lname, :rank)
  end
end
