class ChassisController < ApplicationController
  before_action :set_chassi, only: [:show, :edit, :update, :destroy]

  # GET /chassis
  # GET /chassis.json
  def index
    @chassis = Chassi.all
    render json: @chassis
  end

  # GET /chassis/1
  # GET /chassis/1.json
  def show
    if @chassi.nil?
      head :not_found
    else
      render json: @chassi.properties
    end
  end

  # POST /chassis
  # POST /chassis.json

  # PATCH/PUT /chassis/1
  # PATCH/PUT /chassis/1.json
  def update
    begin
      if update_chassi (chassi_params)
        head :no_content
      else
        render json: @chassi.errors, status: :unprocessable_entity
      end
    rescue ActionController::ParameterMissing => e
      head :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chassi
      @chassi = begin
        Chassi.find(params[:id])
      rescue Mongoid::Errors::DocumentNotFound => ex
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chassi_params
      params.require(:chassi).to_hash.deep_symbolize_keys

    end

    def update_chassi(chassi_update_params)

      chassi_update_params.each do |key, value|
        @chassi.properties[key] = value
      end

      @chassi.save
    end
end
