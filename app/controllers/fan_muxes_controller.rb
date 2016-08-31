class FanMuxesController < ApplicationController
  before_action :set_fan_mux, only: [:show]

  # GET /fanMuxes
  # GET /fanMuxes.json
  def index
    @fan_muxes = FanMux.all.to_a
    render(json: @fan_muxes.map do |fan_mux| 
      setup_fan_mux_properties fan_mux
      fan_mux.properties
    end)
  end

  # GET /fanMuxes/1
  # GET /fanMuxes/1.json
  def show
    if @fan_mux.nil?
      head :not_found
    else
      render json: @fan_mux.properties
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fan_mux
      @fan_mux = begin
                   FanMux.find(params[:id])
                   rescue Mongoid::Errors::DocumentNotFound => ex
                 end
      setup_fan_mux_properties @fan_mux
    end

    def setup_fan_mux_properties(fan_mux)
      return if fan_mux.nil?
      excludeAttributes = split_to_sym params[:excludeAttributes]
      includeAttributes = split_to_sym params[:includeAttributes]
      unless includeAttributes.nil?
        excludeAttributes = FanMuxesHelper::required_fields-includeAttributes
      end
      unless excludeAttributes.nil?
        excludeAttributes.each do |attribute|
          fan_mux.properties.delete(attribute)
        end
      end
    end

    def split_to_sym(string)
      string.split(",").map(&:to_sym) if string.is_a?(String)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fan_mux_params
      params.require(:fan_mux).permit(:_id, :properties)
    end
end
