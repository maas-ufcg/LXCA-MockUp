class CmmsController < ApplicationController
  before_action :set_cmm, only: [:show, :edit, :update, :destroy]

  # GET /cmms
  # GET /cmms.json
  def index
    param = params[:status]
    formatType = params[:formatType]
    if param.nil?
      @cmms = Cmm.all.to_a
    else
      @cmms = Cmm.all.to_a.select do |cmm|
        cmm.properties.to_hash.deep_symbolize_keys[:status][:message] == param
      end
    end
    render(json: @cmms.map do |cmm|
      setup_cmm_properties cmm
      cmm.properties
    end)
  end

  # GET /cmms/1
  # GET /cmms/1.json
  def show
    if @cmms.nil?
      head :not_found
    else
      render(json: @cmms.map {|n|
        setup_cmm_properties n
        n.properties })
    end
  end

  # PATCH/PUT /cmms/1
  # PATCH/PUT /cmms/1.json
  def update
    begin
      @cmm = Cmm.find(params[:id])

      if update_cmm(cmm_params)
        head :no_content
      else
        render json: @cmm.errors, status: :unprocessable_entity
      end
    rescue ActionController::ParameterMissing => e
      head :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cmm
      @cmms = begin
                 params[:id].split(',').map do |id|
                   Cmm.find(id)
                 end
               rescue Mongoid::Errors::DocumentNotFound => ex
               end
    end

    def setup_cmm_properties(cmm)
      return if cmm.nil?
      excludeAttributes = split_to_sym params[:excludeAttributes]
      includeAttributes = split_to_sym params[:includeAttributes]



      unless includeAttributes.nil?
        excludeAttributes = CmmsHelper::required_fields-includeAttributes
      end
      unless excludeAttributes.nil?
        excludeAttributes.each do |attribute|
          cmm.properties.delete(attribute)
        end
      end
    end

    def split_to_sym(string)
      string.split(",").map(&:to_sym) if string.is_a?(String)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cmm_params
      params.require(:cmm).require(:properties).to_hash.deep_symbolize_keys
    end


    def update_cmm(cmm_update_params)
      unless cmm_update_params.nil?

        cmm_update_params.each do |key, value|
          @cmm.properties[key] = value
        end

      @cmm.save

      end
    end

    def setup_cmm_properties(cmm)
      return if cmm.nil?
      excludeAttributes = split_to_sym params[:excludeAttributes]
      includeAttributes = split_to_sym params[:includeAttributes]



      unless includeAttributes.nil?
        excludeAttributes = CmmsHelper::required_fields-includeAttributes
      end
      unless excludeAttributes.nil?
        excludeAttributes.each do |attribute|
          cmm.properties.delete(attribute)
        end
      end
    end

    def split_to_sym(string)
      string.split(",").map(&:to_sym) if string.is_a?(String)
    end

end
