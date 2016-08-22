class ChassisController < ApplicationController
  before_action :set_chassi, only: [:show, :edit, :update, :destroy]

  # GET /chassis
  # GET /chassis.json
  def index
    @chassis = Chassi.all
  end

  # GET /chassis/1
  # GET /chassis/1.json
  def show
  end

  # GET /chassis/new
  def new
    @chassi = Chassi.new
  end

  # GET /chassis/1/edit
  def edit
  end

  # POST /chassis
  # POST /chassis.json
  def create
    @chassi = Chassi.new(chassi_params)

    respond_to do |format|
      if @chassi.save
        format.html { redirect_to @chassi, notice: 'Chassi was successfully created.' }
        format.json { render :show, status: :created, location: @chassi }
      else
        format.html { render :new }
        format.json { render json: @chassi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chassis/1
  # PATCH/PUT /chassis/1.json
  def update
    respond_to do |format|
      if @chassi.update(chassi_params)
        format.html { redirect_to @chassi, notice: 'Chassi was successfully updated.' }
        format.json { render :show, status: :ok, location: @chassi }
      else
        format.html { render :edit }
        format.json { render json: @chassi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chassis/1
  # DELETE /chassis/1.json
  def destroy
    @chassi.destroy
    respond_to do |format|
      format.html { redirect_to chassis_url, notice: 'Chassi was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chassi
      @chassi = Chassi.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chassi_params
      params.require(:chassi).permit(:_id, :properties)
    end
end
