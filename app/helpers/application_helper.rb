module ApplicationHelper
  include Pagy::Frontend

  def format_date(value)
    value.present? ? value.strftime("%d/%m/%Y") : "—"
  end

  def format_datetime(value)
    value.present? ? value.strftime("%d/%m/%Y %H:%M") : "—"
  end

  def format_decimal(value, precision: 2)
    return "—" if value.nil?
    format("%.#{precision}f", value.to_f).tr(".", ",")
  end

  def format_km(value)
    return "—" if value.nil?
    number_with_delimiter(value)
  end

  def format_currency(value)
    return "—" if value.nil?
    "R$ #{format_decimal(value)}"
  end

  def vehicle_status_label(value)
    {
      "active" => "Ativo",
      "in_maintenance" => "Em manutenção",
      "inactive" => "Inativo"
    }[value.to_s] || value.to_s
  end

  def vehicle_status_options
    Vehicle.statuses.keys.map { |k| [ vehicle_status_label(k), k ] }
  end

  def maintenance_kind_label(value)
    {
      "preventive" => "Preventiva",
      "corrective" => "Corretiva"
    }[value.to_s] || value.to_s
  end

  def maintenance_kind_options
    MaintenanceOrder.kinds.keys.map { |k| [ maintenance_kind_label(k), k ] }
  end

  def maintenance_status_label(value)
    {
      "open" => "Aberta",
      "scheduled" => "Agendada",
      "completed" => "Concluída"
    }[value.to_s] || value.to_s
  end

  def maintenance_status_options
    MaintenanceOrder.statuses.keys.map { |k| [ maintenance_status_label(k), k ] }
  end

  def maintenance_status_badge(value)
    klass = {
      "open" => "text-bg-danger",
      "scheduled" => "text-bg-warning",
      "completed" => "text-bg-success"
    }[value.to_s] || "text-bg-secondary"
    tag.span maintenance_status_label(value), class: "badge #{klass}"
  end

  def vehicle_status_badge(value)
    klass = {
      "active" => "text-bg-success",
      "in_maintenance" => "text-bg-warning",
      "inactive" => "text-bg-secondary"
    }[value.to_s] || "text-bg-secondary"
    tag.span vehicle_status_label(value), class: "badge #{klass}"
  end

  def user_role_label(value)
    value.to_s == "admin" ? "Admin" : "Operador"
  end

  def document_label(field)
    {
      "crlv_expiration" => "CRLV",
      "insurance_expiration" => "Seguro",
      "ipva_expiration" => "IPVA"
    }[field.to_s] || field.to_s
  end

  def report_sort_link(column, label)
    new_direction = (params[:sort] == column && params[:direction] == "asc") ? "desc" : "asc"
    arrow = if params[:sort] == column
              params[:direction] == "asc" ? " ▲" : " ▼"
            else
              ""
            end
    link_to "#{label}#{arrow}".html_safe,
            maintenance_report_path(request.query_parameters.except(:page, :format).merge(sort: column, direction: new_direction))
  end
end
