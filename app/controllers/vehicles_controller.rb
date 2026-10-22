class VehiclesController < ApplicationController
  before_action :set_vehicle, only: %i[ show edit update destroy ]

  # GET /vehicles
  def index
    @vehicles = Vehicle.order(:model, :plate)
  end

  # GET /vehicles/1
  def show
  end

  # GET /vehicles/new
  def new
    @vehicle = Vehicle.new
  end

  # GET /vehicles/1/edit
  def edit
  end

  # POST /vehicles
  def create
    @vehicle = Vehicle.new(vehicle_params)

    if @vehicle.save
      redirect_to @vehicle, notice: "Veículo criado com sucesso."
    else
      render :new, status: :unprocessable_content
    end
  end

  # PATCH/PUT /vehicles/1
  def update
    if @vehicle.update(vehicle_params)
      redirect_to @vehicle, notice: "Veículo atualizado com sucesso.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  # DELETE /vehicles/1
  def destroy
    @vehicle.destroy!
    redirect_to vehicles_path, notice: "Veículo removido com sucesso.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = Vehicle.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def vehicle_params
      params.expect(vehicle: [ :plate, :model, :year, :kind, :status, :odometer, :crlv_expiration, :insurance_expiration, :ipva_expiration ])
    end
end
