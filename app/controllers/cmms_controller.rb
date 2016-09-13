class CmmsController < ApplicationController
  before_action :set_cmm, only: [:show, :update]

  # GET /cmms
  # GET /cmms.json
  def index
    @cmms = Cmm.all
    render json: @cmms
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


  # PATCH/PUT /cmms/1
  # PATCH/PUT /cmms/1.json
  def update
      begin

        if update_cmm(cmm_params)
          head :no_content
        else
          render json: @cmm.errors, status: :unprocessable_entity
        end

      rescue ActionController::ParameterMissing => e
        head :unprocessable_entity
      end
  end



  private
    def set_cmm
      @cmm = begin
                  Cmm.find(params[:id])
                rescue Mongoid::Errors::DocumentNotFound => ex
                end

    end

    def cmm_params
      params.require("properties").deep_symbolize_keys

    end

    def update_cmm(cmm_update_params)

      cmm_update_params.each do |key,value|

        @cmm.properties[key] = value

      end

      @cmm.save
    end


end
