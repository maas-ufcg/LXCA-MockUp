class CanistersController < ApplicationController
  before_action :set_canister, only: [:show, :edit, :update, :destroy]

  # GET /canisters
  # GET /canisters.json
  def index
    @canisters = Canister.all
  end

  # GET /canisters/1
  # GET /canisters/1.json
  def show
  end

  # GET /canisters/new
  def new
    @canister = Canister.new
  end

  # GET /canisters/1/edit
  def edit
  end

  # POST /canisters
  # POST /canisters.json
  def create
    @canister = Canister.new(canister_params)

    respond_to do |format|
      if @canister.save
        format.html { redirect_to @canister, notice: 'Canister was successfully created.' }
        format.json { render :show, status: :created, location: @canister }
      else
        format.html { render :new }
        format.json { render json: @canister.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /canisters/1
  # PATCH/PUT /canisters/1.json
  def update
    respond_to do |format|
      if @canister.update(canister_params)
        format.html { redirect_to @canister, notice: 'Canister was successfully updated.' }
        format.json { render :show, status: :ok, location: @canister }
      else
        format.html { render :edit }
        format.json { render json: @canister.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /canisters/1
  # DELETE /canisters/1.json
  def destroy
    @canister.destroy
    respond_to do |format|
      format.html { redirect_to canisters_url, notice: 'Canister was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_canister
      @canister = Canister.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def canister_params
      params.require(:canister).permit(:_id, :properties)
    end
end
