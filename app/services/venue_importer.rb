class VenueImporter
  attr_accessor :json_file

  def initialize(json_file)
    @json_file = json_file
    @layout = @json_file['venue']['layout']
    @seats_info = @json_file['seats']
    @logger = Logger.new(STDOUT)
  end

  def call
    rows = @layout['rows'].to_i
    cols = @layout['columns'].to_i
    @logger.debug "#{rows} rows and #{cols} of seats will be imported.."
    @venue = import_layout(rows, cols)
    @seats = import_seats_information
    @venue
  end

  private

  def import_layout(rows, cols)
    @venue = Venue.new(rows: rows, columns: cols)
    if @venue.save
      @venue.create_seats
      @logger.info "Venue Imported"
      @venue
    else
      # Error in Venue
      @logger.error('--------------------------')
      @logger.error(venue.errors)
      @logger.error('--------------------------')
      false
    end
  end

  def import_seats_information
    @seats_info.each do |seat_info|
      info = seat_info[1]
      seat = @venue.seats.detect { |s| s.public_id == info['id'] }
      if seat
        info['status'] == 'AVAILABLE' ? seat.release! : seat.select!
        @logger.info("SEAT #{seat_info[1]['id']} SELECTED")
      else
        @logger.error("Couldn't find seat with ID #{seat_info[1]['id']}")
        next
      end
    end
  end
end
