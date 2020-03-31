class VenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :rows, :columns

  attribute :available_seats do |obj|
    obj.available_seats.map(&:public_id)
  end

  # attribute :seats do |obj|
  #   SeatSerializer.new(obj.seats)
  # end
end
