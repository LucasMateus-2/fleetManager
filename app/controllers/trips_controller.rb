class TripsController < ApplicationController
  before_action :set_trip, only: %i[ show edit update destroy ]

  # GET /trips
  def index
    @trips = Trip.includes(:vehicle, :driver).order(started_at: :desc)
  end

  # GET /trips/1
  def show
  end

  # GET /trips/new
  def new
    @trip = Trip.new
  end

  # GET /trips/1/edit
  def edit
  end

  # POST /trips
  def create
    @trip = Trip.new(trip_params)

    if @trip.save
      redirect_to @trip, notice: "Viagem criada com sucesso."
    else
      render :new, status: :unprocessable_content
    end
  end

  # PATCH/PUT /trips/1
  def update
    if @trip.update(trip_params)
      redirect_to @trip, notice: "Viagem atualizada com sucesso.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  # DELETE /trips/1
  def destroy
    @trip.destroy!
    redirect_to trips_path, notice: "Viagem removida com sucesso.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def trip_params
      params.expect(trip: [ :vehicle_id, :driver_id, :started_at, :ended_at, :distance_km ])
    end
end
