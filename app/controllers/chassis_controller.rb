class ChassisController < ApplicationController
  before_action :set_chassi, only: [:show, :edit, :update, :destroy]

  # GET /chassis
  # GET /chassis.json
  def index
    param = params[:status]
    formatType = params[:formatType]
    if param.nil?
      @chassis = Chassi.all.to_a
    else
      @chassis = Chassi.all.to_a.select do |chassi|
        chassi.properties.to_hash.deep_symbolize_keys[:status][:message] == param
      end
    end
    render(json: @chassis.map do |chassi|
      setup_chassi_properties chassi
      chassi.properties
    end)
  end

  # GET /chassis/1
  # GET /chassis/1.json
  def show
    if @chassis.nil?
      head :not_found
    else
      render(json: @chassis.map {|n|
        setup_chassi_properties n
        n.properties })
    end
  end

  # PATCH/PUT /chassis/1
  # PATCH/PUT /chassis/1.json
  def update
    begin
      @chassi = Chassi.find(params[:id])

      if update_chassi(chassi_params)
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
      @chassis = begin
                 params[:id].split(',').map do |id|
                   Chassi.find(id)
                 end
               rescue Mongoid::Errors::DocumentNotFound => ex
               end
    end

    def setup_chassi_properties(chassi)
      return if chassi.nil?
      excludeAttributes = split_to_sym params[:excludeAttributes]
      includeAttributes = split_to_sym params[:includeAttributes]



      unless includeAttributes.nil?
        excludeAttributes = ChassisHelper::required_fields-includeAttributes
      end
      unless excludeAttributes.nil?
        excludeAttributes.each do |attribute|
          chassi.properties.delete(attribute)
        end
      end
    end

    def split_to_sym(string)
      string.split(",").map(&:to_sym) if string.is_a?(String)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chassi_params
      params.require(:chassi).require(:properties).to_hash.deep_symbolize_keys
    end


    def update_chassi(chassi_update_params)
      unless chassi_update_params.nil?

        chassi_update_params.each do |key, value|
          @chassi.properties[key] = value
        end

      @chassi.save

      end
    end

    def setup_chassi_properties(chassi)
      return if chassi.nil?
      excludeAttributes = split_to_sym params[:excludeAttributes]
      includeAttributes = split_to_sym params[:includeAttributes]



      unless includeAttributes.nil?
        excludeAttributes = ChassisHelper::required_fields-includeAttributes
      end
      unless excludeAttributes.nil?
        excludeAttributes.each do |attribute|
          chassi.properties.delete(attribute)
        end
      end
    end

    def split_to_sym(string)
      string.split(",").map(&:to_sym) if string.is_a?(String)
    end

end
