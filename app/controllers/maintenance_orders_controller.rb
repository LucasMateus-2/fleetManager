class MaintenanceOrdersController < ApplicationController
  before_action :set_maintenance_order, only: %i[ show edit update destroy ]

  # GET /maintenance_orders
  def index
    @maintenance_orders = MaintenanceOrder.includes(:vehicle).order(opened_at: :desc)
  end

  # GET /maintenance_orders/1
  def show
  end

  # GET /maintenance_orders/new
  def new
    @maintenance_order = MaintenanceOrder.new
  end

  # GET /maintenance_orders/1/edit
  def edit
  end

  # POST /maintenance_orders
  def create
    @maintenance_order = MaintenanceOrder.new(maintenance_order_params)

    if @maintenance_order.save
      redirect_to @maintenance_order, notice: "Ordem de serviço criada com sucesso."
    else
      render :new, status: :unprocessable_content
    end
  end

  # PATCH/PUT /maintenance_orders/1
  def update
    if @maintenance_order.update(maintenance_order_params)
      redirect_to @maintenance_order, notice: "Ordem de serviço atualizada com sucesso.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  # DELETE /maintenance_orders/1
  def destroy
    @maintenance_order.destroy!
    redirect_to maintenance_orders_path, notice: "Ordem de serviço removida com sucesso.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maintenance_order
      @maintenance_order = MaintenanceOrder.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def maintenance_order_params
      params.expect(maintenance_order: [ :vehicle_id, :kind, :status, :opened_at, :scheduled_for, :odometer, :released_at, :description ])
    end
end
