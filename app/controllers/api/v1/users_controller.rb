class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # POST /user
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      # render json: {error: 'unable to create user'}, stauts: 400
      render json: { errors: @user.errors }, status: 422
    end
  end

  # GET /user/:id
  def show
    if stale?(last_modified: @user.updated_at)
      render json: @user
    end

    ## alternative used in applicateion_controller
    # rescue ActiveRecord::RecordNotFound => error
    #   render json: { message: "no user found", status: 404 }, status: 404
  end

  # PUT /users/:id
  def update
    if @user.update(user_params)
      render json: { message: params[:id] + " Update successfull" }, status: 200
    else
      render json: { errors: @user.errors }, status: 422
    end
    ## alternative used in applicateion_controller
    # rescue ActiveRecord::RecordNotFound => error
    #   render json: { message: "no user found", status: 404 }, status: 404
  end

  # DELETE /users/:id
  ## prevent destroy if username is "amiamitswe"
  def destroy
    # @user = User.find(params[:id])
    if @user.username === "amiamitswe"
      render json: { message: "This user can't be deleted" }, status: 403
    else
      if @user.destroy
        render json: { message: "Delete success" }, status: 200
      else
        render json: { message: "Unable to delete" }, status: 400
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
