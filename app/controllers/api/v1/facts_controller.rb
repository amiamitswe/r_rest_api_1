class Api::V1::FactsController < ApplicationController
  def index
    @facts = Fact.all
    render json: @facts
  end

  def show
    @fact = Fact.find(params[:id])
    render json: @fact
  end

  def create
    @fact = Fact.new(fact_params)

    if @fact.save
      render json: @fact
    else
      render json: { errors: @fact.errors }, status: 422
    end
  end

  private

  def fact_params
    params.require(:fact).permit(:message, :likes, :user_id)
  end

end
