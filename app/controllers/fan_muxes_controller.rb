class FanMuxesController < ApplicationController
  before_action :set_fan_mux, only: [:show]

  # GET /fan_muxes
  # GET /fan_muxes.json
  def index
    @fan_muxes = FanMux.all
    render json: @fan_muxes
  end

  # GET /fan_muxes/1
  # GET /fan_muxes/1.json
  def show
    if @fan_mux.nil?
      head :not_found
    else
      render json: @fan_mux
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fan_mux
      @fan_mux = begin
                   FanMux.find(params[:id])
		 rescue Mongoid::Errors::DocumentNotFound => ex
                 end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fan_mux_params
      params.require(:fan_mux).permit(:_id, :properties)
    end
end
