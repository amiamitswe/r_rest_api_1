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
      render json: {
               errors: @user.errors,
             },
             status: 422
    end
  end

  # GET /user/:id
  def show
    @user = User.find(params[:id])

    render json: @user
  end
end
