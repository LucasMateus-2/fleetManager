# Este arquivo cria dados realistas para demonstração do protótipo.
# Rode com: bin/rails db:seed
today = Date.current

puts "Criando usuários..."
admin = User.create!(
  email_address: "admin@frota.com.br",
  password: "senha123",
  role: :admin
)
User.create!(
  email_address: "operador@frota.com.br",
  password: "senha123",
  role: :operator
)

puts "Criando veículos..."
vehicles_data = [
  { plate: "ABC1D23", model: "Toyota Corolla", year: 2022, kind: "Sedan",    status: :active,         odometer: 45_200, crlv: today + 10.days,  insurance: today + 90.days, ipva: today + 40.days },
  { plate: "DEF2E34", model: "Fiat Strada",    year: 2021, kind: "Picape",   status: :active,         odometer: 38_150, crlv: today + 150.days, insurance: today + 20.days, ipva: today + 60.days },
  { plate: "GHI3F45", model: "VW Gol",         year: 2020, kind: "Hatch",    status: :active,         odometer: 52_900, crlv: today - 5.days,   insurance: today + 200.days, ipva: today - 10.days },
  { plate: "JKL4G56", model: "Ford Ranger",    year: 2023, kind: "Picape",   status: :in_maintenance, odometer: 21_400, crlv: today + 300.days, insurance: today + 180.days, ipva: today + 120.days },
  { plate: "MNO5H67", model: "Chevrolet Onix", year: 2022, kind: "Hatch",    status: :active,         odometer: 30_800, crlv: today + 25.days,  insurance: today + 80.days, ipva: today + 70.days },
  { plate: "PQR6I78", model: "Hyundai HB20",   year: 2021, kind: "Hatch",    status: :active,         odometer: 41_600, crlv: today + 210.days, insurance: today + 15.days, ipva: today + 90.days },
  { plate: "STU7J89", model: "Toyota Hilux",   year: 2023, kind: "Picape",   status: :active,         odometer: 18_750, crlv: today + 350.days, insurance: today + 30.days, ipva: today + 110.days },
  { plate: "VWX8K90", model: "Renault Kwid",   year: 2020, kind: "Hatch",    status: :inactive,       odometer: 61_000, crlv: today + 45.days,  insurance: today + 60.days, ipva: today + 55.days },
  { plate: "YZA9L01", model: "Fiat Fiorino",   year: 2019, kind: "Furgão",   status: :active,         odometer: 75_400, crlv: today + 12.days,  insurance: today + 100.days, ipva: today + 30.days },
  { plate: "BCD0M12", model: "Jeep Compass",   year: 2022, kind: "SUV",      status: :in_maintenance, odometer: 28_900, crlv: today + 90.days,  insurance: today + 45.days, ipva: today + 20.days }
]

vehicles = vehicles_data.map do |v|
  Vehicle.create!(
    plate: v[:plate],
    model: v[:model],
    year: v[:year],
    kind: v[:kind],
    status: v[:status],
    odometer: v[:odometer],
    crlv_expiration: v[:crlv],
    insurance_expiration: v[:insurance],
    ipva_expiration: v[:ipva]
  )
end

puts "Criando motoristas..."
drivers_data = [
  { name: "Carlos Souza",   cnh: "12345678900", cnh_expiration: today + 2.years, vehicle: vehicles[0] },
  { name: "Ana Lima",       cnh: "23456789011", cnh_expiration: today + 1.year,  vehicle: vehicles[1] },
  { name: "João Pereira",   cnh: "34567890122", cnh_expiration: today + 2.years, vehicle: vehicles[2] },
  { name: "Maria Santos",   cnh: "45678901233", cnh_expiration: today - 30.days, vehicle: vehicles[4] },
  { name: "Pedro Alves",    cnh: "56789012344", cnh_expiration: today + 3.years, vehicle: vehicles[5] },
  { name: "Juliana Costa",  cnh: "67890123455", cnh_expiration: today + 1.year,  vehicle: vehicles[6] }
]

drivers = drivers_data.map do |d|
  Driver.create!(
    name: d[:name],
    cnh: d[:cnh],
    cnh_expiration: d[:cnh_expiration],
    vehicle: d[:vehicle]
  )
end

puts "Criando ordens de serviço..."
maintenance_data = [
  # concluídas (preventivas/corretivas passadas)
  { vehicle: 0, kind: :preventive, status: :completed, opened_at: today - 90.days, scheduled_for: today - 88.days, odometer: 40_100, released_at: today - 87.days, description: "Troca de óleo e filtro" },
  { vehicle: 0, kind: :corrective, status: :completed, opened_at: today - 30.days, scheduled_for: today - 29.days, odometer: 44_500, released_at: today - 28.days, description: "Substituição das pastilhas de freio dianteiras" },
  { vehicle: 1, kind: :preventive, status: :completed, opened_at: today - 60.days, scheduled_for: today - 58.days, odometer: 35_000, released_at: today - 57.days, description: "Revisão de 30.000 km" },
  { vehicle: 2, kind: :corrective, status: :completed, opened_at: today - 45.days, scheduled_for: today - 44.days, odometer: 50_200, released_at: today - 43.days, description: "Troca da bateria" },
  { vehicle: 3, kind: :preventive, status: :completed, opened_at: today - 120.days, scheduled_for: today - 118.days, odometer: 18_000, released_at: today - 117.days, description: "Revisão de 20.000 km e alinhamento" },
  { vehicle: 5, kind: :preventive, status: :completed, opened_at: today - 75.days, scheduled_for: today - 73.days, odometer: 38_500, released_at: today - 72.days, description: "Troca de óleo, filtro e balanceamento" },
  { vehicle: 6, kind: :corrective, status: :completed, opened_at: today - 20.days, scheduled_for: today - 19.days, odometer: 17_900, released_at: today - 18.days, description: "Reparo no sistema de ar-condicionado" },
  { vehicle: 8, kind: :preventive, status: :completed, opened_at: today - 50.days, scheduled_for: today - 48.days, odometer: 72_000, released_at: today - 47.days, description: "Troca de correia dentada e tensor" },
  { vehicle: 9, kind: :corrective, status: :completed, opened_at: today - 15.days, scheduled_for: today - 14.days, odometer: 27_500, released_at: today - 13.days, description: "Troca de amortecedores traseiros" },
  { vehicle: 4, kind: :preventive, status: :completed, opened_at: today - 40.days, scheduled_for: today - 38.days, odometer: 29_000, released_at: today - 37.days, description: "Revisão de 30.000 km" },
  # agendadas
  { vehicle: 0, kind: :preventive, status: :scheduled, opened_at: today - 5.days,  scheduled_for: today + 5.days,  odometer: 45_200, released_at: nil, description: nil },
  { vehicle: 1, kind: :preventive, status: :scheduled, opened_at: today - 3.days,  scheduled_for: today + 10.days, odometer: 38_150, released_at: nil, description: nil },
  { vehicle: 3, kind: :corrective, status: :scheduled, opened_at: today - 2.days,  scheduled_for: today + 3.days,  odometer: 21_400, released_at: nil, description: nil },
  { vehicle: 5, kind: :preventive, status: :scheduled, opened_at: today - 8.days,  scheduled_for: today + 2.days,  odometer: 41_600, released_at: nil, description: nil },
  { vehicle: 9, kind: :preventive, status: :scheduled, opened_at: today - 1.day,   scheduled_for: today + 7.days,  odometer: 28_900, released_at: nil, description: nil },
  # abertas
  { vehicle: 2, kind: :corrective, status: :open, opened_at: today - 2.days,  scheduled_for: nil,             odometer: 52_900, released_at: nil, description: nil },
  { vehicle: 4, kind: :corrective, status: :open, opened_at: today - 1.day,   scheduled_for: nil,             odometer: 30_800, released_at: nil, description: nil },
  { vehicle: 6, kind: :preventive, status: :open, opened_at: today,           scheduled_for: nil,             odometer: 18_750, released_at: nil, description: nil },
  { vehicle: 8, kind: :corrective, status: :open, opened_at: today - 4.days,  scheduled_for: nil,             odometer: 75_400, released_at: nil, description: nil },
  { vehicle: 9, kind: :corrective, status: :open, opened_at: today - 6.days,  scheduled_for: nil,             odometer: 28_900, released_at: nil, description: nil }
]

maintenance_data.each do |m|
  MaintenanceOrder.create!(
    vehicle: vehicles[m[:vehicle]],
    kind: m[:kind],
    status: m[:status],
    opened_at: m[:opened_at],
    scheduled_for: m[:scheduled_for],
    odometer: m[:odometer],
    released_at: m[:released_at],
    description: m[:description]
  )
end

puts "Criando abastecimentos..."
fueling_prices = [6.19, 6.29, 6.09, 6.35, 6.24]
active_vehicles = [vehicles[0], vehicles[1], vehicles[2], vehicles[5], vehicles[6], vehicles[8]]

active_vehicles.each do |vehicle|
  base_km = vehicle.odometer
  dates = [today - 60.days, today - 45.days, today - 30.days, today - 15.days]
  dates.each_with_index do |date, i|
    km = base_km - (dates.size - i) * 520
    liters = (35 + rand(15)).round(1)
    price = fueling_prices[i % fueling_prices.size]
    Fueling.create!(
      vehicle: vehicle,
      date: date,
      liters: liters,
      cost: (liters * price).round(2),
      odometer: km
    )
  end
end

puts "Criando viagens..."
trips_data = [
  { vehicle: 0, driver: 0, started_at: today - 10.days, ended_at: today - 8.days,  distance_km: 320 },
  { vehicle: 1, driver: 1, started_at: today - 7.days,  ended_at: today - 6.days,  distance_km: 180 },
  { vehicle: 2, driver: 2, started_at: today - 5.days,  ended_at: today - 5.days,  distance_km: 90 },
  { vehicle: 5, driver: 4, started_at: today - 4.days,  ended_at: today - 3.days,  distance_km: 260 },
  { vehicle: 6, driver: 5, started_at: today - 3.days,  ended_at: today - 2.days,  distance_km: 410 },
  { vehicle: 1, driver: 1, started_at: today - 2.days,  ended_at: today - 1.day,   distance_km: 150 },
  { vehicle: 0, driver: 0, started_at: today,          ended_at: nil,             distance_km: nil }
]

trips_data.each do |t|
  Trip.create!(
    vehicle: vehicles[t[:vehicle]],
    driver: drivers[t[:driver]],
    started_at: t[:started_at],
    ended_at: t[:ended_at],
    distance_km: t[:distance_km]
  )
end

puts "Seed concluído!"
puts "  Admin:    admin@frota.com.br / senha123"
puts "  Operador: operador@frota.com.br / senha123"
