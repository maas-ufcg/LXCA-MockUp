class FansController < ApplicationController
  before_action :set_fan, only: [:show]

  # GET /fans
  # GET /fans.json
  def index
    @fans = Fan.all
    render json: @fans
  end

  # GET /fans/1
  # GET /fans/1.json
  def show
    if @fan.nil?
      head :not_found
    else
      render json: @fan
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fan
      @fan = begin
               Fan.find(params[:id])
             rescue Mongoid::Errors::DocumentNotFound => ex
             end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fan_params
      params.require(:fan).permit(:_id, :properties)
    end
end
