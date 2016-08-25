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
    respond_to do |format|
      if @switch.update(switch_params)
        format.html { redirect_to @switch, notice: 'Switch was successfully updated.' }
        format.json { render :show, status: :ok, location: @switch }
      else
        format.html { render :edit }
        format.json { render json: @switch.errors, status: :unprocessable_entity }
      end
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
      params.require(:switch).permit(:_id, :properties)
    end
end
