class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_logged_in, only: [:show, :edit, :update, :destroy]
  before_action :restrict_to_current_user, only: [:show, :edit]
  
  # GET /users
  # GET /users.json
  def index
   
    @user = User.new
    @events = Event.all
  end

  # GET /users/1
  # GET /users/1.json
  def show

      @event = Event.new
      @events = Event.all
      @attendee = Attendee.new
         
  end

  # def attendee_destroy(event_id) 
  #   Attendee.where("user_id = ? AND #{event_id} = ?", params[:id])

  # end 

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        #log user in upon sign up
        session[:user_id] = @user.id
        #redirect to their home page 
        format.html { redirect_to user_path(current_user), notice: 'Welcome to WythMe!' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    
    respond_to do |format|
     
     
      if @user.update(user_params)

        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :city, :about, :first_name, :last_name, :avatar)

    end
end
