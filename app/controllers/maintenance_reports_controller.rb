require "csv"

class MaintenanceReportsController < ApplicationController
  SORTABLE = {
    "opened_at" => "maintenance_orders.opened_at",
    "scheduled_for" => "maintenance_orders.scheduled_for",
    "vehicle" => "vehicles.model",
    "plate" => "vehicles.plate",
    "odometer" => "maintenance_orders.odometer",
    "released_at" => "maintenance_orders.released_at",
    "description" => "maintenance_orders.description"
  }.freeze

  def index
    scope = filtered_scope

    respond_to do |format|
      format.html do
        @pagy, @orders = pagy(scope, limit: 15)
      end
      format.csv do
        send_data csv_data(scope),
                  filename: "relatorio_manutencao_#{Date.current.strftime("%Y%m%d")}.csv",
                  type: "text/csv"
      end
    end
  end

  private

  def filtered_scope
    scope = MaintenanceOrder.joins(:vehicle).includes(:vehicle)

    scope = scope.where("maintenance_orders.opened_at >= ?", parse_date(params[:start_date])) if params[:start_date].present?
    scope = scope.where("maintenance_orders.opened_at <= ?", parse_date(params[:end_date])) if params[:end_date].present?

    if params[:q].present?
      term = "%#{params[:q]}%"
      scope = scope.where("vehicles.model LIKE :term OR vehicles.plate LIKE :term", term: term)
    end

    if params[:status].present? && MaintenanceOrder.statuses.key?(params[:status])
      scope = scope.where(status: params[:status])
    end

    column = SORTABLE[params[:sort]]
    if column.nil?
      scope.order(opened_at: :desc)
    else
      direction = params[:direction] == "desc" ? "desc" : "asc"
      scope.order(Arel.sql("#{column} #{direction}"))
    end
  end

  def parse_date(value)
    Date.parse(value)
  rescue ArgumentError
    nil
  end

  def csv_data(scope)
    CSV.generate(headers: true) do |csv|
      csv << [ "Data de Abertura", "Data Agendada", "Veículo", "Placa", "km", "Data de Saída", "O que foi feito" ]
      scope.find_each do |order|
        csv << [
          order.opened_at&.strftime("%d/%m/%Y"),
          order.scheduled_for&.strftime("%d/%m/%Y"),
          order.vehicle.model,
          order.vehicle.plate,
          order.odometer,
          order.released_at ? order.released_at.strftime("%d/%m/%Y") : "Em andamento",
          order.description
        ]
      end
    end
  end
end
