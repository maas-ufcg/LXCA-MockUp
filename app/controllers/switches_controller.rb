class SwitchesController < ApplicationController
  before_action :set_switch, only: [:show, :update]

  # GET /switches
  # GET /switches.json
  def index
    @switches = Switch.all
    render json: @switches
  end

  # GET /switches/1
  # GET /switches/1.json
  def show
    if @switch.nil?
      head :not_found
    else
      render json: @switch.properties
    end
  end


  # PATCH/PUT /switches/1
  # PATCH/PUT /switches/1.json
  def update
      begin
        if update_switch (switch_params)
          head :no_content
        else
          render json: @switch.errors, status: :unprocessable_entity
        end
      rescue ActionController::ParameterMissing => e
        head :unprocessable_entity
      end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_switch
      @switch = begin
                  Switch.find(params[:id])
                rescue Mongoid::Errors::DocumentNotFound => ex
                end

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def switch_params
      params.require(:switch).require(:properties).to_hash.deep_symbolize_keys
      # begin
      #   params.require(:switch).require(:properties).to_hash.deep_symbolize_keys
      # rescue ActionController::ParameterMissing => e
      #     render :nothing => true, :status => :unprocessable_entity
      #     head :unprocessable_entity
      # end
    end

    def update_switch(switch_update_params)
      # TODO: Verify a white list to only send valid params.
      #  if not verify_params(switch_update_params.keys)
      #    return false
      #  end

      switch_update_params.each do |key,value|

        @switch.properties[key] = value

      end

      @switch.save
    end

    # TODO: Verify a white list to only send valid params.
    # def verify_params(params_properties)
    #   params_properties
    #   params_properties.each do |k|
    #     if(not k.is_a? Symbol )
    #       k = k.to_sym
    #     end
    #     if not SwitchesHelper::params_white_list.include? k
    #       return false
    #     end
    #   end
    #
    #   true
    # end

end
