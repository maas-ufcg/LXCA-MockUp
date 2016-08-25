class FansController < ApplicationController
  before_action :set_fan, only: [:show]

  # GET /fans
  # GET /fans.json
  def index
    @fans = Fan.all.to_a
    render(json: @fans.map do |fan| 
      setup_fan_properties fan
      fan.properties
    end)
  end

  # GET /fans/1
  # GET /fans/1.json
  def show
    if @fan.nil?
      head :not_found
    else
      render json: @fan.properties
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fan
      @fan = begin
               Fan.find(params[:id])
             rescue Mongoid::Errors::DocumentNotFound => ex
             end
      setup_fan_properties @fan
    end

    def setup_fan_properties(fan)
      return if fan.nil?
      excludeAttributes = params[:excludeAttributes]
      includeAttributes = params[:includeAttributes]
      unless includeAttributes.nil?
        excludeAttributes = FansHelper::required_fields - includeAttributes.map(&:to_sym)
      end
      unless excludeAttributes.nil?
        excludeAttributes.map(&:to_sym).each do |attribute|
          fan.properties.delete(attribute)
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fan_params
      params.require(:fan).permit(:_id, :properties)
    end
end
