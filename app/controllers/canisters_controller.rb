class CanistersController < ApplicationController
  before_action :set_canister, only: [:show, :edit, :update, :destroy]

  # GET /canisters
  # GET /canisters.json
  def index
    param = params[:status]
    formatType = params[:formatType]
    if param.nil?
      @canisters = Canister.all.to_a
    else
      @canisters = Canister.all.to_a.select do |canister|
        canister.properties.to_hash.deep_symbolize_keys[:status][:message] == param
      end
    end
    render(json: @canisters.map do |canister|
      setup_canister_properties canister
      canister.properties
    end)
  end

  # GET /canisters/1
  # GET /canisters/1.json
  def show
    if @canisters.nil?
      head :not_found
    else
      render(json: @canisters.map {|n|
        setup_canister_properties n
        n.properties })
    end
  end

  # PATCH/PUT /canisters/1
  # PATCH/PUT /canisters/1.json
  def update
    begin
      @canister = Canister.find(params[:id])

      if update_canister(canister_params)
        head :no_content
      else
        render json: @canister.errors, status: :unprocessable_entity
      end
    rescue ActionController::ParameterMissing => e
      head :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_canister
      @canisters = begin
                 params[:id].split(',').map do |id|
                   Canister.find(id)
                 end
               rescue Mongoid::Errors::DocumentNotFound => ex
               end
    end

    def setup_canister_properties(canister)
      return if canister.nil?
      excludeAttributes = split_to_sym params[:excludeAttributes]
      includeAttributes = split_to_sym params[:includeAttributes]



      unless includeAttributes.nil?
        excludeAttributes = CanistersHelper::required_fields-includeAttributes
      end
      unless excludeAttributes.nil?
        excludeAttributes.each do |attribute|
          canister.properties.delete(attribute)
        end
      end
    end

    def split_to_sym(string)
      string.split(",").map(&:to_sym) if string.is_a?(String)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def canister_params
      params.require(:canister).require(:properties).to_hash.deep_symbolize_keys
    end


    def update_canister(canister_update_params)
      unless canister_update_params.nil?

        canister_update_params.each do |key, value|
          @canister.properties[key] = value
        end

      @canister.save

      end
    end

    def setup_canister_properties(canister)
      return if canister.nil?
      excludeAttributes = split_to_sym params[:excludeAttributes]
      includeAttributes = split_to_sym params[:includeAttributes]



      unless includeAttributes.nil?
        excludeAttributes = CanistersHelper::required_fields-includeAttributes
      end
      unless excludeAttributes.nil?
        excludeAttributes.each do |attribute|
          canister.properties.delete(attribute)
        end
      end
    end

    def split_to_sym(string)
      string.split(",").map(&:to_sym) if string.is_a?(String)
    end

end
