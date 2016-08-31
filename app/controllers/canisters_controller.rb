class CanistersController < ApplicationController
  before_action :set_canister, only: [:show, :edit, :update, :destroy]

  # GET /canisters
  # GET /canisters.json
  def index
    @canisters = Canister.all.to_a
    render(json: @canisters.map do |canister|
      setup_canister_properties canister
      canister.properties
    end)
  end

  # GET /canisters/1
  # GET /canisters/1.json
  def show
    if @canister.nil?
      head :not_found
    else
      render json: @canister.properties
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_canister
      @canister = begin
               Canister.find(params[:id])
             rescue Mongoid::Errors::DocumentNotFound => ex
             end
      setup_canister_properties @canister
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
      params.require(:canister).permit(:_id, :properties)
    end

end
