class Api::V1::UsersController < ApplicationController
  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # POST /user
  def create
    @user = User.new(params.require(:user).permit(:username, :password))
    if @user.save
      render json: @user
    else
      # render json: {error: 'unable to create user'}, stauts: 400
      render json: { errors: @user.errors }, status: 422
    end
  end

  # GET /user/:id
  def show
    @user = User.find(params[:id])

    if stale?(last_modified: @user.updated_at)
      render json: @user
    end
  end

  # PUT /users/:id
  def update
    @user = User.find(params[:id])

    if @user.update(params.require(:user).permit(:username, :password))
      render json: { message: params[:id] + " Update successfull" }, status: 200
    else
      render json: { errors: @user.errors }, status: 422
    end
  rescue ActiveRecord::RecordNotFound => error
    render json: { message: "no user found", status: 404 }, status: 404
  end
end
