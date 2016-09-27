class SwitchesController < ApplicationController
  before_action :set_switch, only: [:show, :update]

  # GET /switches
  # GET /switches.json
  def index

    param = params[:status]
    formatType = params[:formatType]
    if param.nil?
      @switches = Switch.all.to_a
    else
      @switches = Switch.all.to_a.select do |switch|
        switch.properties.to_hash.deep_symbolize_keys[:status][:message] == param
      end
    end
    render(json: @switches.map do |switch|
      setup_switch_properties switch
      switch.properties
    end)
  end

  # GET /switches/1
  # GET /switches/1.json
  def show
    if @switches.nil?
      head :not_found
    else
      render(json: @switches.map {|n|
        setup_switch_properties n
        n.properties })
      end
    end


    private

    def setup_switch_properties(switch)
      return if switch.nil?
      excludeAttributes = split_to_sym params[:excludeAttributes]
      includeAttributes = split_to_sym params[:includeAttributes]



      unless includeAttributes.nil?
        excludeAttributes = SwitchesHelper::required_fields-includeAttributes
      end
      unless excludeAttributes.nil?
        excludeAttributes.each do |attribute|
          switch.properties.delete(attribute)
        end
      end
    end

    def split_to_sym(string)
      string.split(",").map(&:to_sym) if string.is_a?(String)
    end


    def set_switch
      @switches = begin
                params[:id].split(',').map do |id|
                    Switch.find(id)
                  end
                rescue Mongoid::Errors::DocumentNotFound => ex
                end
                setup_switch_properties @switch
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def switch_params
      params.require(:switch).permit(:_id, :properties)
    end

    def update_switch(switch_update_params)
      switch_update_params.each do |key,value|
        @switch.properties[key] = value
      end
      @switch.save
    end

end
