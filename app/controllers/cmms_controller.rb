class CmmsController < ApplicationController
  before_action :set_cmm, only: [:show]

  # GET /cmms
  # GET /cmms.json
  def index
    @cmms = Cmm.all.to_a
    render(json: @cmms.map do |cmm|
      setup_cmm_properties cmm
      cmm.properties
    end)
  end

  # GET /cmms/1
  # GET /cmms/1.json
  def show
    if @cmm.nil?
      head :not_found
    else
      render json: @cmm.properties
    end
  end

  private

# Use callbacks to share common setup or constraints between actions.
  def set_cmm
    @cmm = begin
            Cmm.find(params[:id])
            rescue Mongoid::Errors::DocumentNotFound => ex
            end
    setup_cmm_properties @cmm
    end

  def setup_cmm_properties(cmm)
    return id cmm.nil?
    excludeAttributes = split_to_sym params[:excludeAttributes]
    includeAttributes = split_to_sym params[:includeAttributes]
    unless includeAttributes.nil?
      excludeAttributes = CmmHelper::required_fields-includeAttibutes
    end
    unless excludeAttributes.nil?
     excludeAttributes.each do |attribute|
        cmm.properties.delete(attribute)
      end
    end
  end

  def sprit_to_sym(string)
    string.split(", ").map(&:to_sym) if string.is_a?(String)
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def fan_params
    params.require(:fan).permit(:_id, :properties)
  end
end
