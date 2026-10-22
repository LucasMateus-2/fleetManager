class HomeController < ApplicationController
  def index
    @vehicles_active = Vehicle.active.count
    @vehicles_in_maintenance = Vehicle.in_maintenance.count
    @month_cost = Fueling.where(date: Date.current.all_month).sum(:cost)

    @document_alerts = []
    Vehicle.order(:model).find_each do |vehicle|
      %i[crlv_expiration insurance_expiration ipva_expiration].each do |field|
        date = vehicle.public_send(field)
        @document_alerts << { vehicle: vehicle, document: field, expiration: date } if date&.between?(Date.current, 30.days.from_now)
      end
    end

    @maintenance_alerts = MaintenanceOrder.includes(:vehicle)
                                           .where.not(status: :completed)
                                           .where(scheduled_for: Date.current..30.days.from_now)
                                           .order(:scheduled_for)
  end
end
