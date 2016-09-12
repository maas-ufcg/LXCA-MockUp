class ScalableComplexController < ApplicationController

  before_action :set_scalableComplex, only: [:show]

  #GET /scalable_complex
  #GET /scalable_complex.json
  def index
    param = params[:status]
    formatType = params[:formatType]
    if param.nil?
      @scalableComplexes = ScalableComplex.all.to_a
    else
      @scalableComplexes = ScalableComplex.all.to_a.select do |scalableComplex|
        scalableComplex.properties.to_hash.deep_symbolize_keys[:status][:message] == param
      end
    end
    render(json: @scalableComplexes.map do |scalableComplex|
      setup_scalableComplex_properties node
      scalableComplex.properties
    end)
  end

  #GET /scalable_complex/1
  #GET /scalable_complex/1.json
  def show
    if @scalableComplex.nil?
      head :not_found
    else
      render json: @scalableComplex.properties
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_scalableComplex
    @scalableComplex = begin
                ScalableComplex.find(params[:id])
                rescue Mongoid::Errors::DocumentNotFound => ex
              end
  end

  def setup_scalableComplex_properties(scalableComplex)
    return if scalableComplex.nil?
    excludeAttributes = split_to_sym params[:excludeAttributes]
    includeAttributes = split_to_sym params[:includeAttributes]



    unless includeAttributes.nil?
      excludeAttributes = ScalableComplexHelper::required_fields-includeAttributes
    end
    unless excludeAttributes.nil?
      excludeAttributes.each do |attribute|
        scalableComplex.properties.delete(attribute)
      end
    end
  end
end
