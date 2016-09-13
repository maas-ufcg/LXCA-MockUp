class PowerSuppliesController < ApplicationController
  before_action :set_power_supply, only: [:show]

  # GET /power_supplies
  # GET /power_supplies.json
  def index
    @power_supplies = PowerSupply.all.to_a
    render(json: @power_supplies.map do |power_supply|
      setup_power_supply_properties power_supply
      power_supply.properties
    end)
  end

  # GET /power_supplies/1
  # GET /power_supplies/1.json
  def show
    if @power_supply.nil?
      head :not_found
    else
      render json: @power_supply.properties
    end
  end

  private

    def set_power_supply
      @power_supply = begin
            PowerSupply.find(params[:id])
          rescue Mongoid::Errors::DocumentNotFound => ex
      end
      setup_power_supply_properties @power_supply
    end

    def setup_power_supply_properties(power_supply)
      return if power_supply.nil?
      excludeAttributes = split_to_sym params[:excludeAttributes]
      includeAttributes = split_to_sym params[:includeAttributes]
      unless includeAttributes.nil?
        excludeAttributes = PowerSuppliesHelper::required_fields-includeAttributes
      end
      unless excludeAttributes.nil?
        excludeAttributes.each do |attribute|
          power_supply.properties.delete(attribute)
        end
      end
    end

    def split_to_sym(string)
      string.split(",").map(&:to_sym) if string.is_a?(String)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fan_params
      params.require(:fan).permit(:_id, :properties)
    end
end

  # # GET /power_supplies/new
  # def new
  #   @power_supply = PowerSupply.new
  # end
  #
  # # GET /power_supplies/1/edit
  # def edit
  # end
  #
  # # POST /power_supplies
  # # POST /power_supplies.json
  # def create
  #   @power_supply = PowerSupply.new(power_supply_params)
  #
  #   respond_to do |format|
  #     if @power_supply.save
  #       format.html { redirect_to @power_supply, notice: 'Power supply was successfully created.' }
  #       format.json { render :show, status: :created, location: @power_supply }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @power_supply.errors, status: :unprocessable_entity }
  #     endscalableComplex
  #   end
  # end
  #
  # # PATCH/PUT /power_supplies/1
  # # PATCH/PUT /power_supplies/1.json
  # def update
  #   respond_to do |format|
  #     if @power_supply.update(power_supply_params)
  #       format.html { redirect_to @power_supply, notice: 'Power supply was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @power_supply }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @power_supply.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # DELETE /power_supplies/1
  # # DELETE /power_supplies/1.json
  # def destroy
  #   @power_supply.destroy
  #   respond_to do |format|
  #     format.html { redirect_to power_supplies_url, notice: 'Power supply was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end
  #
  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_power_supply
  #     @power_supply = PowerSupply.find(params[:id])
  #   end
  #
  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def power_supply_params
  #     params.require(:power_supply).permit(:_id, :properties)
  #   end
