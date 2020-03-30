class Api::VenuesController < Api::BaseController
  before_action :find_venue, only: %i[show select_seat best_seat]
  before_action :find_seat, only: %i[select_seat]

  # GET /api/v1/venues
  def index
    @venues = Venue.all.includes(:seats)
    render_json(venue_serializer, @venues)
  end

  # GET /api/v1/venues/:id
  def show
    render_json(venue_serializer, @venue)
  end

  # POST /api/v1/venues
  def create
    @venue = Venue.new(venue_params)
    if @venue.save
      render_json(venue_serializer, @venue)
    else
      render_error_response(@venue.errors)
    end
  end

  # POST /api/v1/venues/import
  def import
    @venue = VenueImporter.new(import_params).call
    render_json(venue_serializer, @venue)
  end

  # POST /api/v1/venues/select_seat
  def select_seat
    render_error_response('Seat is not available') && return unless @seat.available?
    # Select a seat
    @venue.select_seat(@seat)
    render_json(seat_serializer, @seat)
  end

  # GET /api/v1/venues/:id/best_seat
  def best_seat
    @best_seat = @venue.find_best_seat
    render_not_found_response('No Best seat due availability') && return unless @best_seat
    render_json(seat_serializer, @best_seat)
  end

  private

  def venue_params
    params.require(:venue).permit(:rows, :columns)
  end

  def import_params
    params.require(:json).permit!
  end

  def find_venue
    @venue = Venue.find_by(id: params[:id])
    render_not_found_response('Venue not found') && return unless @venue
  end

  def find_seat
    @seat = @venue.seats.find_by(row: format_row, column: params[:column])
    render_not_found_response('Seat not found') && return unless @seat
  end

  def format_row
    # If the row is a char, we find the position as a number.
    (params[:row].is_a? Integer) ? params[:row] : Seat.find_row(params[:row])
  end

  def venue_serializer
    VenueSerializer
  end

  def seat_serializer
    SeatSerializer
  end
end
