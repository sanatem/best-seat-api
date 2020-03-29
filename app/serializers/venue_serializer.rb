class VenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :rows, :columns

  # attribute :seats do |obj|
  #   SeatSerializer.new(obj.seats)
  # end
end
