class DriversController < ApplicationController
  before_action :set_driver, only: %i[ show edit update destroy ]

  # GET /drivers
  def index
    @drivers = Driver.order(:name)
  end

  # GET /drivers/1
  def show
  end

  # GET /drivers/new
  def new
    @driver = Driver.new
  end

  # GET /drivers/1/edit
  def edit
  end

  # POST /drivers
  def create
    @driver = Driver.new(driver_params)

    if @driver.save
      redirect_to @driver, notice: "Motorista criado com sucesso."
    else
      render :new, status: :unprocessable_content
    end
  end

  # PATCH/PUT /drivers/1
  def update
    if @driver.update(driver_params)
      redirect_to @driver, notice: "Motorista atualizado com sucesso.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  # DELETE /drivers/1
  def destroy
    @driver.destroy!
    redirect_to drivers_path, notice: "Motorista removido com sucesso.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_driver
      @driver = Driver.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def driver_params
      params.expect(driver: [ :name, :cnh, :cnh_expiration, :vehicle_id ])
    end
end
