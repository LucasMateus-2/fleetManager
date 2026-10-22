class FuelingsController < ApplicationController
  before_action :set_fueling, only: %i[ show edit update destroy ]

  # GET /fuelings
  def index
    @fuelings = Fueling.includes(:vehicle).order(date: :desc, id: :desc)
  end

  # GET /fuelings/1
  def show
  end

  # GET /fuelings/new
  def new
    @fueling = Fueling.new
  end

  # GET /fuelings/1/edit
  def edit
  end

  # POST /fuelings
  def create
    @fueling = Fueling.new(fueling_params)

    if @fueling.save
      redirect_to @fueling, notice: "Abastecimento criado com sucesso."
    else
      render :new, status: :unprocessable_content
    end
  end

  # PATCH/PUT /fuelings/1
  def update
    if @fueling.update(fueling_params)
      redirect_to @fueling, notice: "Abastecimento atualizado com sucesso.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  # DELETE /fuelings/1
  def destroy
    @fueling.destroy!
    redirect_to fuelings_path, notice: "Abastecimento removido com sucesso.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fueling
      @fueling = Fueling.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def fueling_params
      params.expect(fueling: [ :vehicle_id, :date, :liters, :cost, :odometer ])
    end
end
